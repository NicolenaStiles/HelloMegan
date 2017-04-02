import RPi.GPIO as GPIO
import time
import sys

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BOARD)
GPIO.setup(16, GPIO.OUT)
GPIO.setup(18, GPIO.OUT)
GPIO.setup(22, GPIO.OUT)
GPIO.setup(11, GPIO.OUT)
GPIO.setup(13, GPIO.OUT)
GPIO.setup(15, GPIO.OUT)

name = sys.argv[1]
status = sys.argv[2]

allNames = ["Bec_Jones", "Nicolena_Stiles", "Megan_Lane", "Jen_Bondarchuk"]
pins = [16,18,22,11,13,15]
pinNameDict = {}

for i in range(len(allNames)):
	pinNameDict[allNames[i]] = pins[i]

print(pinNameDict[name])
print(status)
if status == "1":
	GPIO.output(pinNameDict[name],True)
else:
	GPIO.output(pinNameDict[name],False)
