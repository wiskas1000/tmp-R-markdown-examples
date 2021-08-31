# Usage: include this file in the folder. Paste the code below in your file. Then you can use the functions below.
# source("./ProcessingFunctions.R") 

# Converts a string with a postal code to a 4-digit number
# 
# @param inputstring	String with the postal code. Must be of the format "4385CH".
# @return postalcode integer, 1000 < postalcode < 10000
# 
# Example: getPostalcode("4385CH")  --> 4385
# Example: getPostalcode("4385 CH") --> NaN
# Example: getPostalcode("4385")    --> NaN
getPostalcode <- function(inputstring){
  if(is.character(inputstring)){
    if(nchar(inputstring) == 6) {
      postalcode = substr(inputstring, 1, 4)
      postalcode = as.numeric(postalcode)
      
      if(is.na(postalcode)){
	message("getPostalcode(): Missing value.")  
	message(inputstring)  
	message(postalcode)
	return(NaN)
      }
      
      # check if 1000 < postalcode <= 9999
      if((1000 < postalcode) && (postalcode < 10^5)) {
	return(postalcode)     
      }
      else {
	message("getPostalcode(): Weird input. Could not process input correctly.")  
	return(NaN)
      }
    }
    else {
      message("getPostalcode(): incorrect inputsize")  
      return(NaN)
    }
  }
  else {
    message("getPostalcode(): input is not a string")  
    return(NaN)
  }
}

# Converts a string with a date to a 4-digit year number
# @param inputstring	String with the Date. Must be of the format "03.05.2000".
# @return year
# 
# Example: extractYear("03.05.2000")	--> 2000
# Example: extractYear("03 05 2000")	--> NaN
# Example: extractYear"2000")		--> NaN
extractYear <- function(inputstring){
  if(is.character(inputstring)){
    if(nchar(inputstring) == 10) {
      # check for "03.05.2000" structure and extract year
      tempregex = regexec("[[:digit:]]{2}[[:punct:]][[:digit:]]{2}[[:punct:]]([[:digit:]]{4,4})",inputstring)
      tempregmatches = regmatches(inputstring, tempregex)      
      tmpyear <- sapply(tempregmatches, function(x) x[2])
      
      if(is.na(tmpyear)) {
	message("extractYear(): Weird input. Could not process input correctly.")  
	return(NaN)     
      }
      else {
	return(as.numeric(tmpyear))
      }
    }
    else {
      message("extractYear(): incorrect input (size)")  
      return(NaN)
    }
  }
  else {
    message("extractYear(): input is not a string")  
    return(NaN)
  }
}
