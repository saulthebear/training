#!/bin/python3

import math
import os
import random
import re
import sys

#
# Complete the 'timeConversion' function below.
#
# The function is expected to return a STRING.
# The function accepts STRING s as parameter.
#

def timeConversion(s):
    timeParts = re.split(r'(\d\d):(\d\d):(\d\d)([A,P]M)', s)[1:-1]
    tHours = int(timeParts[0])
    minutes = timeParts[1]
    seconds = timeParts[2]
    partOfDay = timeParts[3]
    
    mHours = tHours
    
    if(tHours == 12):
        if(partOfDay == 'AM'):
            mHours = 0
    elif(partOfDay == 'PM'):
        mHours = tHours + 12
    
    return f'{str(mHours).zfill(2)}:{minutes}:{seconds}'
            
    

if __name__ == '__main__':
    fptr = open(os.environ['OUTPUT_PATH'], 'w')

    s = input()

    result = timeConversion(s)

    fptr.write(result + '\n')

    fptr.close()

