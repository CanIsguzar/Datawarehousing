import pyodbc
import sys
import os
import requests
import json
import datetime

HUBS = []
LINKS = []
SATS = []


def main():
    db_src = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=ANBC;TRUSTED_CONNECTION=yes')
    cursor = db_src.cursor()

    # ETL Extract
    consignment_data = cursor.execute(
        """ SELECT * FROM consignment_fact""").fetchall()
    
    consignment_fact = []
    weather_dim = []
    personeel_dim = []
    time_dim = []
    consignment_data.sort(key=lambda x: x[0])
    for consignment in consignment_data:
        sched_pickup_time = consignment[0]
        sched_pickup_date = datetime.datetime.strptime(sched_pickup_time[0:-5], '%Y-%m-%d %H:%M:%S.%f')
        if sched_pickup_date not in [d[1] for d in time_dim]:
            maand = sched_pickup_date.month
            week = sched_pickup_date.isocalendar().week
            dag = sched_pickup_date.day
            jaar = sched_pickup_date.year
            time_dim.append((len(time_dim), sched_pickup_date, maand, week, dag, jaar))
        sched_pickup_date_id = [d[0] for d in time_dim if d[1] == sched_pickup_date][0]


        pickup_time = consignment[11]
        pickup_date = datetime.datetime.strptime(pickup_time[0:-5], '%Y-%m-%d %H:%M:%S.%f')
        if pickup_date not in [d[1] for d in time_dim]:
            maand = pickup_date.month
            week = pickup_date.isocalendar().week
            dag = pickup_date.day
            jaar = pickup_date.year
            time_dim.append((len(time_dim), pickup_date, maand, week, dag, jaar))
        pickup_date_id = [d[0] for d in time_dim if d[1] == pickup_date][0]

        omstandigheden = any(consignment[4:8])
        if omstandigheden not in [o[1] for o in weather_dim]: weather_dim.append((len(weather_dim), omstandigheden))
        weather_id = [o[0] for o in weather_dim if o[1] == omstandigheden][0]

        personeel_id = consignment[3]
        if personeel_id not in [p[0] for p in personeel_dim]: personeel_dim.append((personeel_id, consignment[9], consignment[10]))
        
        consignment_fact.append((int(sched_pickup_date_id), int(pickup_date_id), int(personeel_id), int(weather_id), float(consignment[1]), int(consignment[2])))

    consignment_fact = removeDuplicateKeys(consignment_fact)
    db_src.close()  

    db_dest = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=ANBC_STER;TRUSTED_CONNECTION=yes')
    cursor = db_dest.cursor()
    cursor.executemany(f"INSERT INTO personeel_dim VALUES ({generateQuestionMarks(personeel_dim)})", personeel_dim)
    cursor.executemany(f"INSERT INTO weather_dim VALUES ({generateQuestionMarks(weather_dim)})", weather_dim)
    cursor.executemany(f"INSERT INTO time_dim VALUES ({generateQuestionMarks(time_dim)})", time_dim)
    cursor.executemany(f"INSERT INTO consignment_fact VALUES ({generateQuestionMarks(consignment_fact)})", consignment_fact)
    db_dest.commit()
    db_dest.close()
    

def generateQuestionMarks(object): return (len(object[0]) * '?, ')[:-2]

def removeDuplicateKeys(object):
    unique_data = {}
    result = []

    for item in object:
        key = item[:4] # get the first three columns as a tuple
        if key not in unique_data:
            unique_data[key] = True
            result.append(item)
    return result


if __name__ == "__main__":
    main()
