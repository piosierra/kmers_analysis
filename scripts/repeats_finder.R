
# Naive function to detect repeats larger than size k on a string s. 
# Travels the list creating a named list of kmers and where they occur, and 
# another of the already found repeated ones.


s <- "TGTTTCCTCTAAGATATTGCAGTTCTGCTAAGTTATTCCATTTTAGCAAACTTCTTTTGCTTCTGCAAAGTTTTTACAATTTCTGCAACTTTTCAGCTTTTTCAGCTACTTTTTGCATACAGCTTCAGCTTTAAGCATCCACACTGCATTTTCGCAGGAAATGCAAATTTTTCTAGTTATTGTGTGGATGCTTTAAGCATCCACACTATTGAGTTCCTGTTTCTCTTTATTCTTTATTATTATTATTATTATTCTTAGGACTTCCGTACACTTTTCGCCGTAGAACTACTTCCACAATTTTCAGCCGATTTTCACCGTTCAAATTTTAAACTATTCAGCTATTTTTGCTCTTTCCGGCTATGACTTTTGCTATTTTTAACTATTATACTTTTTAAAATATTCCACTTTTTTCCTTTAATTTGTCCCATTGAAATGAATGGGAAACTTCTGCAATTCTGCTAAATTTTGCTTGTTTTTGAAACTTAACTACTTCCTCATATTTTCACCTAGAACAACCATTCAAATTTTAAAATGTTCACAAATTATTGGGCTATTCAGGTATGATTCAGCTTTTTCAAATCTTATACCGTTTTACTTTTATGCCTCTTAAAGTTTTGAGTTTCATTTTTTTGATTTTTCACAAAATACATGTGTTGTTATGGTTGCTATGCTCTTGGCTTCCAGTGTGCCACTGAAGGTTTTGCAATTTTCACTTCATGTCCGAACAACTTCCTGCTACTTGCTCAATTTTCACTCAACTTCCACAAATTATACATCAAAACGTAGGTATTTTTGCTGGCTTTCAGAAAATGTCACCATCATTGTTGTGGGATTTATAGAATTTTGGCAAATCTCCTCAGACTAACACAAGGTCAGAAAACTCTCCATATAAAGTGAATGGAGAGTTTGTTCAAAATCACCGCTGGATTTCTGTAATGAGAGGCATATTCGAATCGTCATATCTCCTTAACGAAGCAAAGTTAAGACATGAGGCTTGTCCCGGTATATCTTCAGACACTCCTGACGCTCACAATTCAAGAATTTCTTTCTCACCTATTACCGTTCTGAAATGAGTTGGACTTGTTTGAGGGTAGGAAATTTGTCCTTCGCTCAGATTTCTTCAGATTTCAAACTGTGGAAATGAACCACTTTTTTCTCTCGTCATAACTTTTTGTTGGATTTCCACAGAGACCTGAAAATTTCCATGATTGTTCACCAAAGCCTGCTGTCTCTTACGGTGAAAGAATGATATCGATACTCCAAATAGATTTAGAGTTAGAAAGCGTTGTTTGAGGGCAAGTCAAGGCAGTTTTTGCTTCGCTCTGCTCAGTTATGGTGCATTAGAAGTCAAATATCTTTAATAATTCATATTTTAATGATAAATTGTTAACACTGGAAGATTCCCCCATCTCTTCTGAACAAAACGGTGTAAGAATGACCGCTCTAGCCCCTACGGTTAGGAAATTATGGTCATTTGTTTGAGGGGAGTCCTCACTATGAGAAATAGGCTGCAATAATCCTGTGCCTCTCTGTGCTGCGTGTGTAAAAAGATGCACCTGTTTTGGCGGGAAAAAGTACACAGGCTCTCTGATTGGTGGATTCAAATTCAGCAGCTCCCAGGCTGACCTAGAAACTTACTTCTCTCTCCCTGTGCATTTTTTTGCTGATTTTTGTCATTTAACAAGTATATTTGAGGGAACCTCAGCATGTTCAGCATTTTTTCAACTGTCCATTTTGCTTTTCCAATTTTTCTGTTTAACTTATTACTATTGTGCTAAATCATACTATTTCTGCTATTTTATAAGATTTGTGCTTAATATACTATTTCTGCTTTTATAGGATTTGTGCTTAATATAGTATTTCTGCTTTTTATAGGATTTGTGCTTAATATAGTATTTCTGCTAAATTATAGTATTTCTGCCAAATTATAATATTTGTGCTAAAACATAGTCTTAATTTAAAATTACAATATTCATAGTTCATCACAGTGTCTCTGGTAAATCACAATATTTCTGCTCTGTTGTACTATTTTTCTAAATCATAGTGTTTCTGTAATGTTTAAGTATTTTTGGCTAAATATATTCTTTCTGTTATCTTATACTATTTCTCCTAAATTCTTGTATTTTTGAGAAGTTATCATGTTTCTGGTAAGTTACAATATTTCTGCTAAATTCTGCTATGCTATTGTATTTCTGCCAAGTATTATGTTTCCTCTAAGATATTGCAGTTCTGCTAAGTTATTACATTTTTGCTAACTTGATGTTCTTCTGCAAAGTTATTAAAATTTCAACAACTTTTTAAACACTGACTTTGATTTCTTCAGCTTCTTCAGCTATTTTCAACTATTTTCAGAAGACAGCTTCAGCTTTACAGTTTCCTCTAAGTGATTGCAGTTCTGCTAAGTTATTCCATTTTAGCAAAGTTCCTTTGCTTCTGCAAAGTTTTTACAATTTCTGCAACTTTTCAGCTTTTTCAGCTACTTTTTGCATACAGCTTCAGCTTTAAGCATCCACACTGCATTTTCGCAGGAAATGCAAATTTTTCTAGTTATT"
l <- nchar(s)
k <- 7

rep <- list()
uniq <- list()
for (i in seq(1,l-k+1,1)) {
  kmer <- substr(s,i,i+k-1)
  if (!(kmer %in% rep)) {
    if (!is.null(uniq[[kmer]])) {
      rep <- c(rep,kmer)
      uniq[[kmer]] <- NULL
    }
    else {
      uniq[[kmer]] <- i
    }
  } 
}

x <- seq(1,nchar(s))
b <- x[x %in% uniq]
plot(b,b)