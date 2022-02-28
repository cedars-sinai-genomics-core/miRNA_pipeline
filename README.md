# miRNA_pipeline  
We use the GeneGlobe portal from Qiagen to do the primary processing for miRNA data. 

## Process data in GeneGlobe
1. Go to qiagen.com/geneglobe

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
