>TLDR: "What the FUCK IS GooStack?!"
Goo's are a common, 'slime-lime' enemy found in one of my favorite RPGs. Basically, this is the 'magic' behind the engine. Each item does it's own thing.

Base: Basic Kernel and Engine Drivers
Core: Basic Engine APIs for Container Interface
DB: Database and Database Language
Fu: Common Cross-Module Data-Structures (or our 'Code-Fu' basic-types)
Gate: Terminal Emulator, Shell and Container Environment
Glue: Common OS and Kernel Types
Lib: Common Game and Engine Types
Magi: GUI Compiler + DSL for UI/UX
Plug: Module System
Ray: Graphics Driver and Runtime Driver
Run: Public Runtime: Game and Game Engine


All of these export to a common module, GooStack. (It is in the name!)

In Shrine, GooStack is the Framework while Torii and the Core Modules are the Engine. A minimal, just framework with only the base Torii (Shrine-Init)
Modules could also exist.


* Check Core for the implementation from the Front-End API

* Check GS for the implementation for the Back-End Architecture

* Also check Torii for any Gate or Glue Modules for Core, as they can be both Front/Back-End specific.

* Some, like the Modules folder such as for Magi, Ray, Base and Run will have Back-End extensions. Magi, for example, must not only be an Immediate GUI
but a compiler and functional language. So this includes thing like tests and hidden implementation details.


See the readme.md and the license.md for the building and the FOSS license for this project!

Warm regards,

-Nicol!
