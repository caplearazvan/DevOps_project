import requests
import datetime
import time
import smtplib, ssl

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
api_key = '2a835afbae56a94492807d7443f80165'
city = 'Timisoara'
lat = 45.713377
long = 45.713377
Kelvin_offset = 273.15

# Function to retrieve the local temperature using OpenWeatherMap API
def get_local_temperature():
    url = 'https://api.openweathermap.org/data/2.5/weather?lat=45,7129868&lon=21,3979073&appid=2a835afbae56a94492807d7443f80165'  # Replace with your city and API key
    response = requests.get(url)
    data = response.json()
    temperature = data['main']['temp']
    feels_like = data['main']['feels_like']
    humidity = data['main']['humidity']
    temp_min = data['main']['temp_min']
    temp_max = data['main']['temp_max']
    city = data['name']

    return temperature, feels_like, humidity, temp_max, temp_min, city


# Main loop
#while True:
values = get_local_temperature()
current_time = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
print("Local Temperature:", int(values[0] - Kelvin_offset), "°C")
print("Current Time:", current_time)
print("Location: ", values[5])
print("Feels like: ", int(values[1] - Kelvin_offset))
print("Min Temperature: ", int(values[3] - Kelvin_offset))
print("Max Temperature: ", int(values[4] - Kelvin_offset))
print("-----------------------")
#time.sleep(600)  # Wait for 10 minutes before updating

    # port = 587  # For SSL
    # # password = input("Type your password and press enter: ")
    #
    # mail_content = '''Hello,
    # This is a simple mail. There is only text, no attachments are there The mail is sent using Python SMTP library.
    # Thank You'''
    #
    # # The mail addresses and password
    # sender_address = 'caplea_razvan@.yahoo.com'
    # sender_pass = input("pss please")
    # receiver_address = 'caplearazvan2@gmail.com'
    # # Setup the MIME
    # message = MIMEMultipart()
    # message['From'] = sender_address
    # message['To'] = receiver_address
    # message['Subject'] = 'A test mail sent by Python. It has an attachment.'  # The subject line
    # # The body and the attachments for the mail
    # message.attach(MIMEText(mail_content, 'plain'))
    # # Create SMTP session for sending the mail
    # session = smtplib.SMTP('smtp.gmail.com', 587)  # use gmail with port
    # session.starttls()  # enable security
    # session.login(sender_address, sender_pass)  # login with mail_id and password
    # text = message.as_string()
    # session.sendmail(sender_address, receiver_address, text)
    # session.quit()
    # print('Mail Sent')