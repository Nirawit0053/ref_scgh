import calendar
import datetime


def current_end_month():
    now = datetime.datetime.now()
    numbermonth=(calendar.monthrange(now.year, now.month)[1])
    return numbermonth
