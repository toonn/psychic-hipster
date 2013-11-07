-- Transpose

transpose::[[a]]->[[a]]
transpose ([]:_) = []
transpose mat = [head l | l <- mat]:transpose [tail l | l <- mat]
