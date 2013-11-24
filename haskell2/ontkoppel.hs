-- Ontkoppelen met lijstcomprehensies

ontkoppel::[(a,b)]->([a],[b])
ontkoppel list = ([a | (a,_) <- list],[snd koppel | koppel <- list])
-- Zelfde oplossing als eerste oefenzitting
