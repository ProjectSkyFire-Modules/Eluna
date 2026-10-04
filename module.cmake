#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#

# Accept an existing build's old option without exposing Lua to the core.
set(MOD_ELUNA_DEFAULT OFF)
if(DEFINED ELUNA)
  set(MOD_ELUNA_DEFAULT "${ELUNA}")
  message(DEPRECATION "ELUNA is now a module. Use -DMOD_ELUNA=ON with -DMODULES=ON.")
endif()
option(MOD_ELUNA "Build the bundled Eluna module" ${MOD_ELUNA_DEFAULT})
set(MODULE_ENABLED ${MOD_ELUNA})
