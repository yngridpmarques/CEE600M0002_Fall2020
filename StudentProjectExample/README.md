# **Student Project Overview**
The goal of this research project is for you to develop a command line executable workflow for a GRReat (generalizable, robust, and reproducible) environmental data science project that is relevant to your thesis or disertation research. 

**Generalizable:** results from your experiment apply to the population as a whole. Your research project should include one or more large-scale global dataset for the purpose of improving or evaluating the generalizability of your experiment to other landscapes/timeframes.

**Robust:** you use statistical methods that work well for the probability and joint probability distributions specific to your data. Your analysis should consider the ways that spatial/temporal autocorrelation and scale dependence, multicollinearity, ommitted variable bias, and non-normal data distributions may impact parameter estimation or model results.

**Reproducible:** your code is complete, annotated, and version controlled. Following your code yield the exact results demonstrated in the paper.

Use this sample resository as a template to create and document your own research workflows. This README document can also be modified to apply to your own project using the subject headers and topics below. 

The repository has five main folders:
* **raw_data:** contains files and folders representing raw quantitative research outputs, datasets downloaded directly from the internet, or subsets of datasets downloaded directly from the internet
* **training_data:** contains analysis-ready data (aka in the format required as an input to your statistical or image generating software), derived from your raw_data files
* **model_outputs:** contains trained statstical models, parameter/weight estimate files, model fit and summary statistics, and predicted and residual values
* **graphics:** contains figures and tables for your research paper
* **code:** contains all code, and required containers or environments, to produce contents of above mentioned files. At a minimum, it should include:
  * *data download/process code:* Database API search scripts and R, python, bash (wget) scripts which link data in your "raw_data" folder to a source stable, version-controlled database or directory.
  * *data process code:* R or python scripts which subset, reproject, gap fill, standardize, extract features, derive indices, and implement any other commands required to convert your raw data into an analysis ready format (generally a data frame, matrix, or array object in R or Python)
  * *model train and validate code:* Code to train an appropriate diagnostive/predictive model relevant to research question. Includes training/validation data subsetting, hyperparameter tuning, extraction of summary and model fit statistics, and extraction of relevant resutls.
  * *table/figure generating code:* Code to generate *at least* 3 figures and a table (as a .csv or .md) from files contained in raw_data, processed_data, and model_outputs.

### *When you adapt this README.md to your own project, make sure to include your research question, literature cited, and methods overview in the "Overview", then edit the folder and code file names to match your project*


# **Installation:**
Unless otherwise discussed with the instructor, code should be written in R, Python, or on occassion, in Bash. The download instructions for the software configuratios recommended by the instructor can be found on our syllabus on the blackboard site.

The sample code provided is written in the R programming language Microsoft R Open 3.5.1 on an Ubuntu Windows Subsystem for Linux OS. Each script is intended to serve as a stand-alone workthrough specific to the data (this is a study, not a software package). 

### *When you configure this "Installation" section to your project, include your 1) operating system, 2) Python/R version, 3)if possible, a conda environment that details required packages and versions. [Learn more about creating and saving a conda environment here] (https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html) and 4) data citations. The idea is that you want to give another user all the information that they'd require to be able to get your code to run from start to finish*

# **Usage:**
The Usage section of your README.md should include step-by-step instructions for how to combine your code and data into your results. For example:

The file data_download.R downloads monthly stratified sea salinity (SSS) and sea temperature (SST) data from 1948-2018 from the United Kingdom Met Office EN 4.2.1 Quality Controlled Dataset (Good et al 2013), extracts sea surface salinity and sea surface temperature (SSS/SST) at 5m depth, cacontonates into a 3D array (as a monthy time series) of gridded values. It creates a subdirectory called "raw_data" and saves these values as a netcdf file ("UKMO4_2_1_analyses_SSS_SST.nc") that raw_data directory. To run this on your computer, specify a "local_dir" (local directory) where you want the data stored and run:

        Rscript data_download.R
        
From your command line. The data_process.R script then creates a training_data directory, reads in the UKMO4_2_1_analyses_SSS_SST.nc file, and uses it to generate a monthly multivaraite time series of SSS/SST precipitation forecast indices described in Carter et al. 2020.

        Rscript data_process.R
        
# **Collaboration:**
If this is going to be a public facing directory, this tells people how you'd like them to use their code. For example:

"Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change."

# **Citation:**
Whenever you use code, analytical frameworks, or data, you need to cite the work that lead to this. Acknowledging or inviting significant code collaborators to join your publications may be appropriate at times as well.

For example, if code or data derived from this work is used in research, please cite:

*Carter, E; Herrera, D; Steinschneider, S. (2020). Feature engineering for S2S warm-season precipitation forecasts in the Midwestern US: towards a unifying hypothesis of anomalous warm-season hydroclimatic circulation. Journal of Climate, in review.*

*As a graduate student you should publish! Put your "in preparation" manuscript here so that folks using your code know where to check back once you've gotten it published.*

# **License:**
[Chose a license here](https://choosealicense.com/)
