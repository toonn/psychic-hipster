-- Ontkoppel

ontkoppel::[(a,b)]->([a],[b])
ontkoppel list = ([a | (a,_) <- list],[snd koppel | koppel <- list])
