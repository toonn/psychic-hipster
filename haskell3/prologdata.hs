-- Datadefinities voor Prolog
data PrologData = Term String [PrologData] | Variable String Int
