@echo off
set xv_path=D:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 64c60b7d6cac44718df918d669826789 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot sim_2b_behav xil_defaultlib.sim_2b xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
