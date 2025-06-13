# ECoG_central
Preprocess all Kyoto ECoG data. These data can then be copied and used in a wide variety of future ECoG projects. 

## Quickstart

1. **Convert data to BIDS format** (well, imperfect BIDS format!). This is mostly automatic, but requires some details to be specified by hand - so, before running the script, edit `specify_json_details.mat`, `specify_channel_details`, and `transfer_miscellaneous_files.m` to match your dataset. Once you are satisfied, run `convert_to_BIDS.m`.


