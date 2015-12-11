# Wranglr 

### Bookmarklet that pulls all of the relevant content from a page and creates a word cloud based on usage

# Process

## Prep 

My first step was admittedly looking up what a bookmarklet was and why they are useful. 
I had no idea it was possible to bookmark scripting tasks like this instead of using the more
user-friendly option of extentions. 

Once I figured out what they were I began to lay out a plan for this task: 

- create a repository
- initialize a node environment for gulp 
- set up basic file structure 

> Anchor tags have a pretty low character limit depending on browser so an external script is necessary

## Initial Design

-  Create the bookmarklet
-  Choose a method of displaying the wordcloud 

Once I was able to log out all the ordered words I knew it was time to figure
out the best way of displaying the results. The easiest route would be injecting a 
div on top of everything else with the results. This could lead to a poor user
experience though. Pages could potentially break, and the markup would be pretty
ugly and hard to update.

This whole project had me thinking about things like Pocket and how it operates. 
If I ever wanted to expand on this application or allow the user (or myself) to  
use this data later, it'd be best to store it on a server somewhere and send them 
a simple link to it. 

### Choosing a framework 

I went with Sinatra because it's lightweight. Rails would be completely overkill here.
All I need for now is a one table database, an about page, and a cloud route. 

> Postgres supports JSON binary but for now a string field is sufficient. If I had 
> more time to work on this and explore JSONB I would probably use that instead

- Implement Rake for migrations with ActiveRecord

## Up and Running 

- Grab all relevant words in the body tag
- Send over to the server to save 
- Parse through and grab the lowest, mean, and highest numbers 
  * Allows for scaling to any size of website or document
  * Keeps a cleanly formatted guide of how large or small words can get
- Alphabetize properly by ignoring case

### Final Touches

After the AJAX call returns, the server sends the client a proper id so the bookmarklet
can build a link to display the word cloud. This is done as a discrete overlay of the current 
page and should cause as minimal damage to the original styling and content as possible. 

The bookmarklet uses Math.random in its script call so that users won't cache version 1.0 
forever should it be updated. 

Set up assets to serve the js and css libraries off the hosted server so the bookmarklet actually works
outside of local dev 

# Other Notes 

This was overall a fun project because I learned about something that's interesting but 
entirely unfamiliar. The biggest hurdle was initially conceptualizing how to organize and 
display the data. I feel that my current setup is a fine solution for both large and small 
uses and it has been left open ended for the future. 






