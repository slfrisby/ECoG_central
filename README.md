# ECoG Central

Preprocess all Kyoto ECoG data. These data can then be copied and used in a wide variety of future ECoG projects. 

## Quickstart

1. **Arrange the raw data** - manually create a directory within your project directory called `/raw/data/` and, within that, create one directory for each patient. When naming the directories, use the same number of digits for each patient's ID - e.g. Pt**01**, ... Pt**22**, *not* Pt**1**, ... Pt**22**. Store the `.mat` files in the patient's directory. 
2. **Arrange additional information about the data** in a directory called `/raw/notes/`.
	- A file called `mni_coordinates.csv` MUST be included. The columns of the file should be patient ID, electrode ID, x-coordinate, y-coordinate, z-coordinate. 
	- You can also include clinical details, stimuli, photos and videos of task performance, etc.
3. **Provide the scripts with important parameters**. Since each ECoG dataset is different, some parameters must be specified by hand before the code can be run. Edit the following scripts to suit your dataset:
	- `specify_json_details.m` records the task and the number of channels of each type (ECoG, sEEG, ECG etc.). This is used to make a sidecar .json (a text-based file containing important information) for each dataset.
	- `specify_channels_tsv.m` records which channels are non-ECoG (sEEG, ECG, trigger etc.) and which channels lie below the seizure onset zone in each participant. This is used to make a file called `channels.tsv` which accompanies each dataset. 
	- `specify_electrode_details.m` is used to make a file called `electrodes.tsv`, one for each patient. In practice, it contains the hemisphere in which electrodes were implanted for each patient.
	- `transfer_misc_files.m` gets useful information about the data (clinical details, MNI coordinates, stimuli, etc.) and saves these files in one organised directory. 
	- `src/README.md` describes the data for the benefit of future users of your dataset. Guidance on what to include can be found here: https://bids.neuroimaging.io/getting_started/templates/index.html#dataset_description.json
4. **Convert data to BIDS format** (well, imperfect BIDS format!) using `convert_to_BIDS.m`.
5. **Run the hands-free section of the preprocessing pipeline** using `preprocess.m`. If you have access to a high-performance cluster, use `sub_job.sh` to preprocess all participants in parallel.
	- Note that the scripts `setup_naming_data.m` and `setup_semantic_judgement_data.m`, called within this script, arrange the data so that each row is a trial. Naming data have 400 rows - 4 blocks of the same 100 stimuli. Within each block, stimuli 1:50 are living and stimuli 51:100 are nonliving. Semantic judgement data have 960 rows - 10 blocks of 96 stimuli. Within each block, stimuli 1:24 are living, stimuli 25:48 are nonliving, stimuli 49:72 are the SAME living stimuli, and stimuli 73:96 are the SAME nonliving stimuli. Blocks are in this order: visual semantic block 1, visual semantic block 2, visual semantic block 3, auditory semantic block 1, auditory semantic block 2, auditory semantic block 3, visual control block 1, visual control block 2, auditory control block 1, auditory control block 2. 


## Optional steps:
- Use `plot_electrode_locations.m` to visualise electrodes on the brain for the whole participant group.
- Use `check_electrode_labelling.m` to create a figure that can be used to conduct a *very* quick visual check of whether a participant's electrodes have been labelled correctly.
- Use `plot_electrode_density.m` to visualise coverage overlap between participants (N.B. this visualisation is a work in progress!)

## Useful links
- Overview of iEEG-BIDS structure: https://bids.neuroimaging.io/getting_started/tutorials/conversion/ieeg.html?h=ieeg
- Glossary - useful for learning what to include in each file and in what format: https://bids-specification.readthedocs.io/en/stable/

