library(ggplot2)

args = commandArgs(trailingOnly=TRUE)
biggest_contigs = "biggest_contigs.dat"

if (length(args)==1) {
 biggest_contigs = args[1] 
}
ctgs <- read.table(biggest_contigs,header=F)
for ( i in ctgs$V1) {
    filename=sprintf("plot/%s.gene_cov_norm.gg.tab", i)
    pdffile = sprintf("plot/%s.gg.pdf",i)
    Title=sprintf("%s - all strains",i)
    cov <- read.table(filename,header=T,sep="\t")
    g = ggplot(cov,aes(GENE,COVERAGE) +
    labs(title=Title) + 
      geom_point(alpha=1/2,size=0.5) + scale_colour_brewer(palette = "Set2")

      ggsave(pdffile,g,width=3,height=3)
}

#,color=GROUP,group=GROUP)) +

