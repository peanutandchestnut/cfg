call util#addThirdLibTags('thirdlib')
"appName, makesure the same target exists in Makefile
let g:mycppMakes = {
			\'default':'ogreApp',
			\'ogreApp':'./ogreApp',
			\'test':'test/test',
			\}
let g:mycppBuildDir = "build"
"let g:mycppPreRequisite=['pacConsolePreRequisite.h']
"let g:mycppStable=['pacStable.h']




"project related macro------------------------------
"define paramcmd:
"   0wdiw:Cnc " ParamCmd5j
