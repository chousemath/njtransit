timeConfig =
    hour: 'numeric'
    minute: 'numeric'
    second: 'numeric'
    hour12: true

weekdays = new Array(7)
weekdays[0] = 'Sunday'
weekdays[1] = 'Monday'
weekdays[2] = 'Tuesday'
weekdays[3] = 'Wednesday'
weekdays[4] = 'Thursday'
weekdays[5] = 'Friday'
weekdays[6] = 'Saturday'

monthNames = new Array()
monthNames[0] = 'Jan'
monthNames[1] = 'Feb'
monthNames[2] = 'Mar'
monthNames[3] = 'Apr'
monthNames[4] = 'May'
monthNames[5] = 'Jun'
monthNames[6] = 'Jul'
monthNames[7] = 'Aug'
monthNames[8] = 'Sep'
monthNames[9] = 'Oct'
monthNames[10] = 'Nov'
monthNames[11] = 'Dec'

timeElement = document.getElementById 'span-time'
dateElement = document.getElementById 'span-date'
expElement = document.getElementById 'span-expiration'
colorElements = document.getElementsByClassName 'container-color-1'
gradientTop = document.getElementById 'container-ticket-gradient-1'
gradientBtm = document.getElementById 'container-ticket-gradient-2'
inputGradient = document.getElementById 'input-gradient'

color1 = document.getElementById 'color-1'
color2 = document.getElementById 'color-2'
color3 = document.getElementById 'color-3'

inputColor1 = document.getElementById 'input-color-1'
inputColor2 = document.getElementById 'input-color-2'
inputColor3 = document.getElementById 'input-color-3'

gradientTop.addEventListener 'click', () ->
    inputGradient.click()

gradientBtm.addEventListener 'click', () ->
    inputGradient.click()

inputGradient.addEventListener 'change', () ->
    console.log inputGradient.value
    gradientTop.style.backgroundImage = "linear-gradient(#{inputGradient.value}, #fff)"
    gradientBtm.style.backgroundImage = "linear-gradient(#fff, #{inputGradient.value})"

color1.addEventListener 'click', () ->
    inputColor1.click()
color2.addEventListener 'click', () ->
    inputColor2.click()
color3.addEventListener 'click', () ->
    inputColor3.click()

inputColor1.addEventListener 'change', () ->
    console.log inputColor1.value
    color1.style.backgroundColor = inputColor1.value

inputColor2.addEventListener 'change', () ->
    console.log inputColor2.value
    color2.style.backgroundColor = inputColor2.value

inputColor3.addEventListener 'change', () ->
    console.log inputColor3.value
    color3.style.backgroundColor = inputColor3.value

timeLimit = 150 * 60 # number of minutes to count down

fullOpacity = true # whether or not the colors are showing
setOpacityTo1 = (element) -> element.style.opacity = "1"
setOpacityTo0 = (element) -> element.style.opacity = "0"

setInterval () ->
    timeLimit--
    date = new Date()
    now = date.toLocaleString('en-US', timeConfig)
    weekday = weekdays[date.getDay()]
    month = monthNames[date.getMonth()]
    day = date.getDate()
    year = date.getFullYear()
    nowString = if now.length == 10 then "0#{now}" else "#{now}"
    dayString = "#{day}"
    if dayString.length == 1
        dayString = "0#{day}"
    dateString = "#{weekday}, #{month} #{dayString}, #{year}"
    # console.log nowString, '\t', dateString
    timeElement.innerHTML = nowString
    dateElement.innerHTML = dateString

    limitHours = Math.floor timeLimit / 3600
    limitMinutes = Math.floor((timeLimit / 60) - limitHours * 60)
    limitSeconds = timeLimit - limitMinutes * 60 - limitHours * 60 * 60

    limitStrHours = "#{limitHours}"
    limitStrMinutes = "#{limitMinutes}"
    limitStrSeconds = "#{limitSeconds}"

    if limitStrHours.length == 1
        limitStrHours = "0#{limitStrHours}"
    if limitStrMinutes.length == 1
        limitStrMinutes = "0#{limitStrMinutes}"
    if limitStrSeconds.length == 1
        limitStrSeconds = "0#{limitStrSeconds}"

    expElement.innerHTML = "Expires in 00:#{limitStrHours}:#{limitStrMinutes}:#{limitStrSeconds}"
    
    if fullOpacity
        fullOpacity = false
        setOpacityTo0 elem for elem in colorElements
    else
        fullOpacity = true
        setOpacityTo1 elem for elem in colorElements

, 1000