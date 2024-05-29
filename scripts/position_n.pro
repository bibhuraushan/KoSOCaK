;+ 
; NAME       : POSITION_N
; PURPOSE    : TO CALCULATE THE POSITION OF THE NORTH POLE IN KODAIKANAL Ca-K DATA
;
; CALLING SEQUENCE:
;     result = POSITION_N(year, month, date, hh, mm, approx=approx)
;
; INPUTS:
;     YEAR  - Integer. The year of the observation.
;     MONTH - Integer. The month of the observation.
;     DATE  - Integer. The date of the observation.
;     HH    - Integer. The hour of the observation (24-hour format).
;     MM    - Integer. The minute of the observation.
;
; OPTIONAL KEYWORDS:
;     approx - Set this keyword to use an approximate calculation for the hour angle.
;
; OUTPUTS:
;     Returns the position of the north pole in degrees.
;
; MODIFICATION HISTORY:
;     [Date]      [Author]       [Modification Description]
;     02/05/2018  Bibhuti Kumar Jha  Created the function.
;
;- 

FUNCTION POSITION_N, YEAR, MONTH, DATE, HH, MM, approx=approx
  COMPILE_OPT IDL2

  ; Latitude and Longitude of Kodaikanal Observatory
  LAT = 10.230d    ; https://www.iiap.res.in/kodai_location
  LON = 77.468d

  ; CALCULATION OF JULIAN DATE FROM TIMING
  ; ADD OFFSET OF 5.5 HR WHICH IS IST AND UT DIFFERENCE
  jd = anytim2jd(timestamp(year=year, month=month, day=date, hour=hh, minute=mm, offset=5.5, /utc))
  jd = double(jd.int) + jd.frac

  ; USING JD TO CALCULATE THE RA DEC OF THE SUN FOR THAT PARTICULAR TIME
  sunpos, jd, ra, dec

  IF KEYWORD_SET(approx) THEN BEGIN
      ; Hour angle calculation (Correct +/-0.5deg)
      hra = hour_angle(year, month, date, hh, mm)
  ENDIF ELSE BEGIN
      ; RA DEC AND LOCATION CAN BE USED TO FIND THE HOUR ANGLE OF THE STAR, HERE SUN
      ; ============================================================================
      ; The effect of nutation, aberration, refraction, and precession have been 
      ; removed by setting these keywords equal (default is 1). These constraints 
      ; are in best agreement with SPA
      ; ============================================================================

      eq2hor, ra, dec, jd, alt, az, hra, lat=LAT, lon=LON, altitude=2343.0, $
        nutate_=0, aberration_=0, refract_=0, precess_=0
  ENDELSE

  ; POLE ANGLE IS THE COMPLEMENT OF DECLINATION
  delta = 90.0 - dec
  
  ; CALCULATION OF ROTATION CAUSED BY SIDEREOSTAT (Cornu, 1900)
  K = sin(0.5d * (LAT - delta) * !dtor) / sin(0.5d * (LAT + delta) * !dtor)
  ang1 = 2.0d * atan(K * tan(0.5d * hra * !Dtor), 1) * !radeg

  ; ANGLE BETWEEN EARTH'S ROTATION AXIS AND SUN'S ROTATION AXIS
  pp = pb0r(timestamp(year=year, month=month, day=date, hour=hh, minute=mm, offset=5.5, /utc))
  
  ; THIS IS TO ADJUST THE OFFSET
  poleangle = 90.0 - (ang1 + pp[0])
  RETURN, poleangle
END
