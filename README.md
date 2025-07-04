# Current miRNA_pipeline
We use Qiagen's RNA Portal to do the primary processing for miRNA data

## Process data
1. Go to https://ngsdataanalysis3.qiagen.com/QIAseqmiRNA/analysisfile . Login info is on SharePoint login spreadsheet (https://cedarssinai.sharepoint.com/:x:/r/sites/InternalGenomics/_layouts/15/doc2.aspx?sourcedoc=%7B3B429E97-CCB4-4BF3-BAED-A606C65196D5%7D&file=Various%20Login%20Info.xlsx&action=default&mobileredirect=true)
2. On the upper left, click "Upload Data" and prior download the trimmed FASTQs for the project.
3. Once the data has been uploaded, click "Align sample data" and select uploaded FASTQ files.
   - Create a new project, using the projectID as the project name.
   - Under "Kit" select "Qiagen"
   - Under "Sample Kit" select "QIAseq miRNA Library Kit"
   - Under "Reference" select the reference for the project
   - Under "Next step" select "Start alignment", then click "Start"
4. Once the alignment has been complete, click the corresponding project, we may start the experiment design portion. Once in the project, on the bottom left click "Create an experiment" and window will be prompted.
   - Name the experiment anything, we are only trying to obtain the count tables from this pipeline
   - Select all FASTQs
   - For the metadata input, select "Manually add attribute" and here the information is arbitrary.
     - This is what to input: name "Group", value "1,2", and randomly assign the samples 1 or 2.
     - Note: the information here is arbitrary because the pipeline wants us to assign groups to create a PCA plot, but we do not deliver this.
   - Under "Experimental design":
     - "Test differential expression due to" select "Group"
     - "Experimental setup (comparisons)" select "All group pairs"
   - Then click start
5. This will take about 10-15 minutes with less than 10 samples, but if there are more come back to the portal when available.
6.  When complete, on the project page, on the right there will be an image with a scatter plot labeled "Experiment summary and QC" and click on that.
7.  There is a tab that says "Quality control" click that and print the page (really saving it as a PDF), this will be the first deliverable and the **QC report**.
   - Note: Or you can click "Print View" and save that page but remove the PCA plots from the file, this is a deliverable and the **QC report**.
8. **IF THE RESEARCHER ORDERED TIER 1, PROCEED TO THIS STEP:** Under the tab, "Samples", there is a button to select/download expression values, download "Mature miRNA values, one file per sample"

## Creating count table from individual expression values for Tier 1
Qiagen does not output a single count table for all samples, therefore we need to create a single table for researchers. The script used to create the table is `miRNA_count_matrix_merging.R` and is stored in the bin folder on HPC and Titan.

1. Upload the files onto HPC/Titan
2. Run with a conda env with tidyverse [below is on Titan, modify accordingly]
```
conda activate singlecell
Rscript /home/genomics/genomics/bin/miRNA_count_matrix_merging.R /path/to/expression/values
```
3. This will output a table called `miRNA_piRNA_trimmed_expression_value.csv` and this will be the second deliverable.

## Tier 1 Deliverables
1. PDF file of the QC metrics, from "Quality Control" tab from the Qiagen project experiment page
2. `miRNA_piRNA_trimmed_expression_value.csv` generated from expression values from "Samples" tabe from the Qiagen project experiment page






# OLD miRNA_pipeline  
We use the GeneGlobe portal from Qiagen to do the primary processing for miRNA data. To access this pipeline:
https://ngsdataanalysis3.qiagen.com/QIAseqmiRNA/analysisfile - for uploading files
https://ngsdataanalysis3.qiagen.com/QIAseqmiRNA/analysisjob - primary analysis jobs
https://dataanalysis.qiagen.com/QIASeqmiRNA/arrayanalysis.php - secondary analysis

## Process data in GeneGlobe
1. Go to https://login.qiagen.com/login?service=https%3A%2F%2Fgeneglobe.qiagen.com%2Fus%2Fanalyze. Login info is on the BOX login spreadsheet

2. Click on “Analyze”
 
3. In the Data Analysis Center:
- Under “Select analysis type”, select “NGS” 
- Under "Select your analyte", select “miRNA”
- Under "Select your panel", select "QIAseq miRNA Library Kit"
- Under "Select analysis pipeline", select "Legacy Analysis Pipelines"
- then click submit, you will now be routed to the "QIAseq miRNA Quantification" portal
     
4. In the "QIAseq miRNA Quantification" portal:
- Select “Upload New Files” and this will bring you to “Data Input Uploader”, upload the FastQ files 
- Once upload is done, go back to "QIAseq miRNA Quantification", select all the FastQ files you would like to process for one project and click on "select for analysis"
- Under “Analysis Jobs”:
     - For "Job Title", input the project ID
     - For "QIAseq Spike-ins Added", select "NO"
     - Select “Species” from the dropdown menu
     - For "File Lanes", select "1-lane" 
     - Then click on "Analyze". The job will be submitted and will run in the background
     - Periodically refresh the page by clicking “miRNA Quantification Jobs” tab. Job status will change from “queued” to
          “in progress” to ultimately “done successfully”.   
     - When the job has finished, you can either click “Download Report” to receive the primary analysis output.

## "QIAseq miRNA Quantification" data analysis   
Step1: Adaptor Trimming  
  • Remove the adapter sequences from the reads  

Step2: Read Mapping  
  • Identify the possible position of the read within the reference  
  • Align the read sequence to reference sequences  

Step3: UMI Counting  
  • Merge unique UMI with mapped reads  
  

## Tier1 analysis output  
• “summary” tab: Important mapping metrics for the sequencing run  
• “miRNA_piRNA” tab: Mapped reads and UMI counts for each miRNA and piRNA found in miRBase  
• “notCharacterized_mappable” tab: Mapped reads and UMI counts for each sequence that aligns to the genome  
