
# set the directory of QGIS
# export QGIS_Dir=C:\Program Files\QGIS 3.10
# set ERRORLEVEL=0

# set variables for project initialisation
export python_script_prepare_qswat=$HOME/.SWAT/SWATPlus/Workflow/main_stages/prepare_project.py
export python_script_make_config=$HOME/.SWAT/SWATPlus/Workflow/main_stages/generate_config.py
export python_script_run_qswat=$HOME/.SWAT/SWATPlus/Workflow/main_stages/run_qswat.py
export python_script_run_editor=$HOME/.SWAT/SWATPlus/Workflow/main_stages/run_editor.py
export python_script_run_calibration=$HOME/.SWAT/SWATPlus/Workflow/main_stages/run_calibration.py
export python_script_make_figures=$HOME/.SWAT/SWATPlus/Workflow/main_stages/run_make_figures.py
export python_script_clean_up=$HOME/.SWAT/SWATPlus/Workflow/main_stages/run_clean_up.py

export BASE_DIR=$PWD
export swatplus_wf_dir=$HOME/.SWAT/SWATPlus/Workflow/
# add qgis plugins folder to pythonpath
export WF_QGIS=/usr/share/qgis/python/plugins

# # add default plugins and model directory to python path
export PYTHONPATH=$HOME/.SWAT/SWATPlus/Workflow/.venv/lib/python3.6/site-packages:$BASE_DIR:$WF_QGIS:$PYTHONPATH
# export PATH=%PATH%

# start runing the workflow using PyQGIS

python3 $python_script_prepare_qswat $BASE_DIR
if [ "$?" -ne "0" ]; 
then
  echo "prepare_qswat failed"
  exit 1
else
    echo 'prepare_qswat done'
    python3 $python_script_make_config $BASE_DIR 
    if [ "$?" -ne "0" ]; 
    then
        echo "make_config failed"
        exit 1
    else
        echo 'make_config done'
        python3 $python_script_run_qswat $BASE_DIR
        if [ "$?" -ne "0" ]; 
        then
            echo "run_qswat failed"
            exit 1
        else
            echo 'run_qswat done'
            python3 $python_script_run_editor $BASE_DIR
            echo 'run_editor done'

            python3 $python_script_run_calibration $BASE_DIR
            echo 'un_calibration done'

            python3 $python_script_make_figures $BASE_DIR
            echo 'make_figures done'
        fi
        
    fi
fi

python3 $python_script_clean_up $BASE_DIR
echo 'clean_up done'

echo 'This is the end.'