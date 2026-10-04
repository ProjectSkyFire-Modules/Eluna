#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#

add_subdirectory(dep/lualib)
target_link_libraries(modules mod_eluna_lua)

# Keep asset staging owned by the module rather than the game target.
if(WIN32)
  if(MSVC)
    set(ELUNA_SCRIPT_DEST "${CMAKE_BINARY_DIR}/bin/$<CONFIG>/lua_scripts")
  else()
    set(ELUNA_SCRIPT_DEST "${CMAKE_BINARY_DIR}/bin/lua_scripts")
  endif()
  add_custom_target(mod_eluna_assets
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ELUNA_SCRIPT_DEST}"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/scripts" "${ELUNA_SCRIPT_DEST}"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_SOURCE_DIR}/extensions" "${ELUNA_SCRIPT_DEST}/extensions"
    VERBATIM)
  add_dependencies(modules mod_eluna_assets)
  install(DIRECTORY scripts/ DESTINATION lua_scripts)
  install(DIRECTORY extensions DESTINATION lua_scripts)
else()
  install(DIRECTORY scripts/ DESTINATION ${CONF_DIR}/lua_scripts)
  install(DIRECTORY extensions DESTINATION ${CONF_DIR}/lua_scripts)
endif()
