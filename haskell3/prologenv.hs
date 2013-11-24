-- PrologEnv

-- prologdata.hs
data PrologData = Term String [PrologData] | Variable
data Variable = Alias Int Int | Ref Int PrologData

-- prologenv.hs
data PrologEnv = MkPrologEnv Int [(Int, Variable)]

emptyPE :: PrologEnv
emptyPE = MkPrologEnv 0 []

newvar :: PrologEnv -> PrologEnv
newvar MkPrologEnv rank heap =
    MkPrologEnv (rank+1) ((rank+1, Alias (rank+1) (rank+1)) : heap)

dereference :: PrologEnv -> Int -> PrologData
dereference (MkPrologEnv rank (index, variable):heap) var
    | index != var = dereference (MkPrologEnv rank heap++(index, variable)) var
    | otherwise = deref (MkPrologEnv rank (index, variable):heap)
deref :: PrologEnv -> PrologData
deref (MkPrologEnv rank (index, Ref ind term):heap) = term
deref (MkPrologEnv rank (index, Alias ind ali):heap) =
    | index == ali = Alias ind ali
    | otherwise = dereference (MkPrologEnv rank heap) ali

bind :: PrologEnv -> Int -> PrologData -> PrologEnv
bind (MkPrologEnv rank (index, variable):heap) var prologdata
    | index != var =
        bind (MkPrologEnv rank heap++(index, variable)) var prologdata
    | otherwise = bind' (MkPrologEnv rank (index, variable):heap) prologdata
bind' :: PrologEnv -> PrologData -> PrologEnv
bind' (MkPrologEnv rank (index, variable):heap) (Alias var ali) =
    MkPrologEnv rank (index, Alias index var):heap
bind' (MkPrologEnv rank (index, variable):heap) (Ref var prologdata) =
    MkPrologEnv rank (index, Alias index var):heap
bind' (MkPrologEnv rank (index, variable):heap) (Term term arguments) =
    MkPrologEnv rank (index, Ref index (Term term arguments))

-- Unificatie
unify :: PrologEnv -> PrologData -> PrologData -> PrologEnv
-- error bij faling
-- termen unificeren als functor == en #args == en args unificeren
-- var en term unificeren altijd, var wordt gebonden
-- twee var unificeren altijd, als != dan hogere rang bind aan lagere
