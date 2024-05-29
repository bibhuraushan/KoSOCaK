;+ 
; NAME:
;   HOUR_ANGLE
;
; PURPOSE:
;   To calculate the hour angle for a given time and location.
;
; CALLING SEQUENCE:
;   hra = HOUR_ANGLE(year, month, date, hh, mm, eqt=eqt)
;
; INPUTS:
;   YEAR  - Integer. The year of the observation.
;   MONTH - Integer. The month of the observation.
;   DATE  - Integer. The date of the observation.
;   HH    - Integer. The hour of the observation (24-hour format).
;   MM    - Integer. The minute of the observation.
;
; OPTIONAL INPUT KEYWORDS:
;   eqt - Named variable to hold the value of the equation of time correction.
;
; OUTPUTS:
;   Returns the hour angle in degrees.
;
; SIDE EFFECTS:
;   None.
;
; EXAMPLE:
;   hra = HOUR_ANGLE(2021, 5, 2, 14, 30, eqt=eqt)
;   PRINT, 'Hour Angle: ', hra
;   PRINT, 'Equation of Time: ', eqt
;
; MODIFICATION HISTORY:
;   Written by: Bibhuti Kumar Jha, 02/05/2018
;-

FUNCTION HOUR_ANGLE, YEAR, MONTH, DATE, HH, MM, eqt=eqt
  COMPILE_OPT IDL2

  ; Latitude and Longitude of the observatory
  phi = 10.23           ; Latitude of Kodaikanal Observatory
  long = 77.46          ; Longitude of Kodaikanal Observatory
  dutc = +5.5           ; Local time offset from UTC
  doy = utc2doy(anytim2utc(timestamp(year=year, month=month, day=date)))

  ; Equation of time correction
  leap = ((year MOD 4) EQ 0) & (year MOD 100) NE 0))
  gamma = (2.0 * !dpi / (365.0 + leap)) * (doy - 1 + (hh - 12) / 24.0)
  eqt = 229.18d * (0.000075 + 0.001868 * COS(gamma) - 0.032077 * SIN(gamma) - 0.014615d * COS(2.0 * gamma) - $
                   0.040849 * SIN(2.0 * gamma))

  ; Local standard time meridian
  lstm = 15.0 * dutc

  ; Time correction
  tc = 4.0 * (long - lstm) + eqt

  ; Local time
  time = hh + mm / 60.0
  lst = time + tc / 60.0

  ; Hour angle 
  hra = (lst - 12.0) * 15.0
  hra[WHERE(hra LT 0)] = hra[WHERE(hra LT 0)] + 360.0

  RETURN, hra
END