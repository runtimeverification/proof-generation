$c \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortK \imp |- ) \in-sort \kore-symbol-dotk ( $.
$v ph0 ph1 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
KSEQ-symbol-1-sorting $a |- ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
${ sorting-cache-1207 $p |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $= ( in-sort-is-pattern KSEQ-symbol-1-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-177 IMP-sort-28-is-pattern imp-is-pattern proof-rule-prop-1 KSEQ-symbol-1-sorting proof-rule-mp ) CDBAEFBCDBGCDBAEFBHIJ $. $}
