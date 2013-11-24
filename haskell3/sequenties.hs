-- Sequenties
import Data.Char

class Sequentie a where
    volgende :: a -> a
    vorige :: a -> a

instance Sequentie Int where
    volgende int = int + 1
    vorige int = int - 1

instance Sequentie Char where
    volgende char = chr ((ord char) + 1)
    vorige char = chr ((ord char) - 1)

instance Sequentie Bool where
    volgende bool = not bool
    vorige = volgende

class Sequentie a => LinksBegrensdeSequentie a where
    eerste :: a

class Sequentie a => RechtsBegrensdeSequentie a where
    laatste :: a

instance LinksBegrensdeSequentie Char where
    eerste = 'a'

instance RechtsBegrensdeSequentie Char where
    laatste = 'z'

instance LinksBegrensdeSequentie Bool where
    eerste = False

instance RechtsBegrensdeSequentie Bool where
    laatste = True
