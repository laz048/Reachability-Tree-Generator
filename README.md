# Reachability Tree Generator
This MATLAB program generates the reachability tree of any petri net (including those with self-loops) by providing I, O, and the intial marking m1. 

The output is a table where the rows are the transitions, the columns are the parent markings, and inside each cell is the next marking (child marking). E.g. table(4,3) contains the next marking after firing transition 4 from marking 3.
