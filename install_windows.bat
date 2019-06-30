SET vimrc_link="%HOMEPATH%\_vimrc"
SET vimrc_target="%~dp0\roles\vim\files\vimrc"
SET vimdir_link="%HOMEPATH%\.vim"
SET vimdir_target="%~dp0\roles\vim\files\vim"
SET gvimrc_link="%HOMEPATH%\_gvimrc"
SET gvimrc_target="%~dp0\roles\vim\files\gvimrc"
SET vimrun_dir="%HOMEPATH%\.vim_run"
SET gitignore_link="%HOMEPATH%\.gitignore"
SET gitignore_target="%~dp0\roles\git\files\gitignore"

if not exist %vimrc_link% (
	mklink %vimrc_link% %vimrc_target%
)
if not exist %vimdir_link% (
	mklink /D %vimdir_link% %vimdir_target%
)
if not exist %gvimrc_link% (
	mklink %gvimrc_link% %gvimrc_target%
)
if not exist %vimrun_dir% (
	md %vimrun_dir%
)
if not exist %gitignore_link% (
	mklink %gitignore_link% %gitignore_target%
)
