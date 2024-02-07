--12 karaktere elejétől a végégig
SELECT 'Data Science' ~ '^............$';

--12 karaktere elejétől a végégig máshogy
SELECT 'Data Science' ~ '^.{12}$';

--legalább 11 karakter az elejétől a végéig
SELECT 'Data Science' ~ '^.{11,}$';

--1-nél több betűből és space-ből áll az elejétől a végéig. Érzékeny a kis és nagybetűkre
SELECT 'Data Science' ~ '^[a-zA-z]+$';

--1-nél több betűből és sapce-ből áll az elejétől a végéig. NEM érzékeny a kis és nagybetűkre
SELECT 'Data Science' ~* '^[a-z ]+$';

SELECT regexp_replace('0036305986092AKOS', '^[+]?(00)?(36)?(\d{2})(\d{3})(\d{4})\w*?','+\2 \3 \4-\5' )

--1-nél több betűvel és/vagy sapce van a végén. NEM érzékeny a kis és nagybetűkre
SELECT 'Data Science' ~* '[a-z ]+$';

--legalább számmal kezdődik
SELECT '2023 Data Science' ~* '^[0-9]+';

--lehet, hogy számmal kezdődik
SELECT 'Data Science' ~* '^[0-9]*', '2023 Data Science' ~* '^[0-9]*';

--pontosan 4 darab számmal kezdődik és space-szel folytatódik
SELECT '2023 Data Science' ~* '^[0-9]{4}\s', '2023 Data Science' ~* '^\d{4}\s';

--pontosan 4 darab számmal kezdődik és space-szel folytatódik és utána lehet még bármilyen kararkter
SELECT '2023 Data Science' ~* '^[0-9]{4}\s.*$', '2023 Data Science' ~* '^\d{4}\s.*$';

--pontosan 4 darab számmal kezdődik és space-szel folytatódik és utána van még 2 szó a végéig
SELECT '2023 Data Science' ~* '^[0-9]{4}\s([a-z]+\s*){2}$'
