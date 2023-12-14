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
        'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=ABC_B;TRUSTED_CONNECTION=yes')
    cursor = db_src.cursor()

    # ETL Extract
    consignment_data = cursor.execute(
        "SELECT * FROM dbo.Consignment").fetchall()
    parcel_of_consignment_data = cursor.execute(
        "SELECT * FROM dbo.parcel_of_consignment").fetchall()
    employee_data = cursor.execute("SELECT * FROM dbo.Employee").fetchall()
    customer_data = cursor.execute("SELECT * FROM dbo.Customer").fetchall()
    district_data = cursor.execute("SELECT * FROM dbo.District").fetchall()
    status_data = cursor.execute("SELECT * FROM dbo.Status").fetchall()
    delivery_price_data = cursor.execute(
        "SELECT * FROM dbo.delivery_price").fetchall()
    weekly_district_devision_data = cursor.execute(
        "SELECT * FROM dbo.weekly_district_division").fetchall()
    parcel_price = cursor.execute(
        "SELECT * FROM dbo.DELIVERY_PRICE").fetchall()

    weather_data = requests.get(
        "https://www.daggegevens.knmi.nl/klimatologie/uurgegevens?fmt=json&start=2004123100&end=2006011600&stns=275:375")
    weather_data = json.loads(weather_data.text)
    db_src.close()

    # Prepare Transform/Load
    hub_customer = []
    hub_consignment = []
    hub_parcel = []
    hub_employee = []
    hub_district = []
    hub_weather = []

    link_consignment_customer = []
    link_consignment_weather = []
    link_parcel_consignment = []
    link_parcel_employee = []
    link_employee_district = []

    sat_customer = []
    sat_consignment = []
    sat_parcel = []
    sat_employee = []
    sat_district = []
    sat_weather = []
    sat_consignment_customer = []

    for i in range(0, len(parcel_of_consignment_data)):
        parcel_of_consignment_data[i][0] = i

    # ETL Transform
    for customer in customer_data:
        if customer[0] not in [x[3] for x in hub_customer]:
            hub_customer.append(
                (len(hub_customer), datetime.datetime.now(), "ABC_B", customer[0]))

    for consignment in consignment_data:
        if consignment[0] not in [x[3] for x in hub_consignment]:
            hub_consignment.append(
                (len(hub_consignment), datetime.datetime.now(), "ABC_B", consignment[0]))

    for parcel in parcel_of_consignment_data:
        if parcel[0] not in [x[3] for x in hub_parcel]:
            hub_parcel.append(
                (len(hub_parcel), datetime.datetime.now(), "ABC_B", parcel[0]))

    for employee in employee_data:
        if employee[0] not in [x[3] for x in hub_employee]:
            hub_employee.append(
                (len(hub_employee), datetime.datetime.now(), "ABC_B", employee[0]))

    for district in district_data:
        if district[0] not in [x[3] for x in hub_district]:
            hub_district.append(
                (len(hub_district), datetime.datetime.now(), "ABC_B", district[0]))

    # Hier wordt niet gefilterd, er kan worden uitgegaan van clean data.
    for weather in weather_data:
        # Add hour to date
        weather['date'] = datetime.datetime.strptime(
            weather['date'], '%Y-%m-%dT%H:%M:%S.%fZ') + datetime.timedelta(hours=weather['hour'])
        hub_weather.append((len(hub_weather), weather['date'], "KNMI"))

    for wdd in weekly_district_devision_data:
        employee_id = [x[0] for x in hub_employee if x[3] == wdd[1]][0]
        district_id = [x[0] for x in hub_district if x[3] == wdd[2]][0]
        link_employee_district.append(
            (district_id, employee_id, datetime.datetime.now(), "ETL", wdd[0], len(link_employee_district)))

    for parcel in parcel_of_consignment_data:
        parcel_id = [x[0] for x in hub_parcel if x[3] == parcel[0]][0]
        employee_id = [x[0] for x in hub_employee if x[3] == parcel[2]][0]
        link_parcel_employee.append(
            (employee_id, parcel_id, datetime.datetime.now(), "ETL"))

    for parcel in parcel_of_consignment_data:
        consignment_id = [x[0]
                          for x in hub_consignment if x[3] == parcel[1]][0]
        parcel_id = [x[0] for x in hub_parcel if x[3] == parcel[0]][0]
        link_parcel_consignment.append(
            (parcel_id, consignment_id, datetime.datetime.now(), "ETL"))

    for consignment in consignment_data:
        customer_id = [x[0] for x in hub_customer if x[3] == consignment[1]][0]
        consignment_id = [x[0]
                          for x in hub_consignment if x[3] == consignment[0]][0]
        link_consignment_customer.append(
            (consignment_id, customer_id, datetime.datetime.now(), "ETL"))

    for consignment in consignment_data:
        consignment_id = [x[0]
                          for x in hub_consignment if x[3] == consignment[0]][0]
        date = consignment[7].replace(second=0, microsecond=0, minute=0)
        src_town = 0 if consignment[2] in [
            'Arnhem-Centrum', 'Arnhem-Zuid', 'Velp'] else 1
        weather = [x for x in hub_weather if x[1] == date][src_town]
        link_consignment_weather.append(
            (consignment_id, weather[0], datetime.datetime.now(), "ETL"))

    for customer in hub_customer:
        origin_customer = [x for x in customer_data if x[0] == customer[3]][0]
        sat_customer.append((customer[0], datetime.datetime.now(), "ETL", origin_customer[1], origin_customer[2],
                            origin_customer[3], origin_customer[4], origin_customer[5], origin_customer[6], origin_customer[7]))

    for consignment in hub_consignment:
        origin_consignment = [
            x for x in consignment_data if x[0] == consignment[3]][0]
        src_town = 0 if origin_consignment[2] in [
            'Arnhem-Centrum', 'Arnhem-Zuid', 'Velp'] else 1
        dest_town = 0 if origin_consignment[4] in [
            'Arnhem-Centrum', 'Arnhem-Zuid', 'Velp'] else 1
        sat_consignment.append((consignment[0], datetime.datetime.now(), "ETL", origin_consignment[3], origin_consignment[4],
                               origin_consignment[5], origin_consignment[7], origin_consignment[8], origin_consignment[12] if origin_consignment[11] == 1 else 0, src_town == dest_town))

    for weather in hub_weather:
        origin_weather = weather_data[weather[0]]
        sat_weather.append((weather[0], datetime.datetime.now(), "ETL", origin_weather["FH"], origin_weather["T"], origin_weather["RH"], origin_weather["P"], origin_weather["VV"],
                           origin_weather["N"], origin_weather["U"], origin_weather["M"], origin_weather["R"], origin_weather["S"], origin_weather["O"], origin_weather["Y"]))

    for parcel in hub_parcel:
        origin_parcel = [
            x for x in parcel_of_consignment_data if x[0] == parcel[3]][0]
        origin_consignment = [
            x for x in consignment_data if x[0] == origin_parcel[1]][0]
        express = 1 if origin_consignment[11] == 1 else 0
        weight = origin_parcel[3]
        price = 0
        for delivery_price in delivery_price_data:
            if weight >= delivery_price[0] and weight <= delivery_price[1] and express == delivery_price[2]:
                price = delivery_price[3]

        sat_parcel.append((parcel[0], datetime.datetime.now(
        ), "ETL", origin_parcel[3], origin_parcel[4] == 1, origin_parcel[5], price))

    for employee in hub_employee:
        origin_employee = [x for x in employee_data if x[0] == employee[3]][0]
        sat_employee.append((employee[0], datetime.datetime.now(), "ETL", origin_employee[1], origin_employee[2], origin_employee[3], origin_employee[4],
                            origin_employee[5], origin_employee[6], origin_employee[7], origin_employee[8], origin_employee[9], origin_employee[10]))

    for district in hub_district:
        origin_district = [x for x in district_data if x[0] == district[3]][0]
        sat_district.append(
            (district[0], datetime.datetime.now(), "ETL", origin_district[1]))

    print(len(hub_customer), len(hub_consignment), len(hub_parcel),
          len(hub_employee), len(hub_district), len(hub_weather))
    print(len(link_employee_district), len(link_parcel_employee), len(
        link_parcel_consignment), len(link_consignment_customer), len(link_consignment_weather))
    print(len(sat_customer), len(sat_consignment), len(sat_weather),
          len(sat_parcel), len(sat_employee), len(sat_district))

    # ETL Load
    db_dest = pyodbc.connect(
        'DRIVER={ODBC Driver 17 for SQL Server};SERVER=localhost;DATABASE=ANBC;TRUSTED_CONNECTION=yes')
    cursor = db_dest.cursor()
    cursor.executemany(
        f"INSERT INTO hub_customer VALUES ({generateQuestionMarks(hub_customer)})", hub_customer)
    cursor.executemany(
        f"INSERT INTO hub_consignment VALUES ({generateQuestionMarks(hub_consignment)})", hub_consignment)
    cursor.executemany(
        f"INSERT INTO hub_parcel VALUES ({generateQuestionMarks(hub_parcel)})", hub_parcel)
    cursor.executemany(
        f"INSERT INTO hub_employee VALUES ({generateQuestionMarks(hub_employee)})", hub_employee)
    cursor.executemany(
        f"INSERT INTO hub_district VALUES ({generateQuestionMarks(hub_district)})", hub_district)
    cursor.executemany(
        f"INSERT INTO hub_weather VALUES ({generateQuestionMarks(hub_weather)})", hub_weather)
    cursor.executemany(
        f"INSERT INTO link_employee_district VALUES ({generateQuestionMarks(link_employee_district)})", link_employee_district)
    cursor.executemany(
        f"INSERT INTO link_parcel_employee VALUES ({generateQuestionMarks(link_parcel_employee)})", link_parcel_employee)
    cursor.executemany(
        f"INSERT INTO link_parcel_consignment VALUES ({generateQuestionMarks(link_parcel_consignment)})", link_parcel_consignment)
    cursor.executemany(
        f"INSERT INTO link_consignment_customer VALUES ({generateQuestionMarks(link_consignment_customer)})", link_consignment_customer)
    cursor.executemany(
        f"INSERT INTO link_consignment_weather VALUES ({generateQuestionMarks(link_consignment_weather)})", link_consignment_weather)
    cursor.executemany(
        f"INSERT INTO sat_customer VALUES ({generateQuestionMarks(sat_customer)})", sat_customer)
    cursor.executemany(
        f"INSERT INTO sat_consignment VALUES ({generateQuestionMarks(sat_consignment)})", sat_consignment)
    cursor.executemany(
        f"INSERT INTO sat_weather VALUES ({generateQuestionMarks(sat_weather)})", sat_weather)
    cursor.executemany(
        f"INSERT INTO sat_parcel VALUES ({generateQuestionMarks(sat_parcel)})", sat_parcel)
    cursor.executemany(
        f"INSERT INTO sat_employee VALUES ({generateQuestionMarks(sat_employee)})", sat_employee)
    cursor.executemany(
        f"INSERT INTO sat_district VALUES ({generateQuestionMarks(sat_district)})", sat_district)
    db_dest.commit()
    cursor.close()


def generateQuestionMarks(object): return (len(object[0]) * '?, ')[:-2]


if __name__ == "__main__":
    main()
