# Cliff notes

# Introduction (1m)
- Katan
- Jorg

# Use case (3m)
- Story about partner portal without going into a tremendous amount of detail
- Migrating apps custom services out of ECC or S/4
- Change as little as possible. Changing services and Fiori apps is more work than just retrofitting the service

# Why, and why this way? (2m)
- Side by side extendibility 
- Clean Core, etc
  - Keeps the old system intact
  - Allows us to start removing completely custom fields and logic out of ABAP
- Faster iterations through CI/CD 

# Demo & Code explanation
- Open repo in browser 

## Beershop
- Shout out to the beershop 
- Run the beershop on port 4005
- Open the beershop on port 4005, 
  - show the relevant beershop entity in CDS
  - Show what's in it via browser or http test

## Devtoberfest extension
- Show general CAP setup
- Super quick overview of importing and integrating an external service
- show package.json and CDS entries

## Solution walkthrough 
- Show results of what we're building
- Talk about the importance of having an aspect to reduce specifying fields everywhere
- Show how the aspect creates both the extension and the persistence
- Comment out the handlers.
- Show the errors that show up simply passing the new entity along 
  - `field does not exist` error
- Walk through the handler. Put `console.log` messages all over the place. Preferably on the fly, for some interactivity
  - Show the SELECT object
  - Show the contents of the aspect in code
  - Show the contents of the remote entity in code
- Explain that these can be changed in the handlers
  - Step by step, comment in bits of code and explain what they do 
- GOT TIME LEFT AFTER READ? Do CREATE. Still time left? UPDATE

# When to use, when not to use 
- Would I still take this approach if I didn't have to support large Fiori apps? 
  - Probably not, association should suffice 
- Potential issues V2 to V4. While the CAP service can transform a V2 app into a V4 app, 
not all functionality can be guaranteed 
- ALTERNATIVE SOLUTION? Create an association, and normalize it with a view 
  - this changes the name of the entity
  - this means maintaining view fields 