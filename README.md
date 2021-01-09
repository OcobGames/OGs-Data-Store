# OGs Data Store

It's basically the same system of my game [Building](https://roblox.com/games/6014589059/NUKE-Building) but improved as a module script.

You can get this module [here](https://roblox.com/library/6213998418/OGs-Data-Store).

***DISCLAIMER: This is still in beta phase, if you find any bugs, please let me know.***

### Setting up the module

Just write this on your script:
```
local Module = require(6213998418)
```

### Functions

There are 4 functions on this module. They are:

```
Module:SetId(id)
Module:Save(key,group)
Module:Load(key,parent)
Module:Clear(key)
```

#### Module:SetId()

This function takes the **id** parameter.

It sets the data store name where you want to save things with **Module:Save()**

#### Module:Save()

This function takes the **key** parameter, and the **group** parameter.

##### **Key**

Key is the data store acess key to the data.

##### **Group**

Group is the origin of the parts. It **must be a folder**.

#### Module:Load()

This function takes the **key** parameter, and the **parent** parameter.

##### **Key**

Key is where the script will look on the data store for data.

##### **Parent**

Parent is where the data will be loaded, for example, a folder in the workspace.

#### Module:Clear()

This function takes the **key** parameter.

It removes all the data in **key**.
