1. Explain which programs/features work
- Program 1 works without error
- Our assembler works
- All hardware modules work
- Branching as defined by our scope works

2. Explain which programs/features don't work and what challenges you faced when
implementing your design
- Program 2 and Program 3 do not work. 
- We had some challenges getting questa to display enough statements to be helpful in debugging
- Had some miscommication with referencing solutions on different branches
- Had some misunderstandings about how bits were indexed
- Had issues trying to get our original branching mechanism to work as our program was much larger than anticipated
- We had to include logic to handle arithamic with signed numbers
- In order to make sure branches were syncrhonized, we had to deisgn our programs to have pre- branch conditionals.
- When defining our control signals, in order to facilitate multiple types of instruction formats, we had to encode for multibit controlsignals.
- In order to have two sets of two bits represent register numbers from 0 to 7, we concatenated a 1 and 0 to these bit sets respectively.
- This however meant that we could only use 4 designated registers for rs and 4 different registers for rt for our r-types which was a limitation that hindered our ability to complere program 2 and 3.
3. Include the link and passcode to zoom video
