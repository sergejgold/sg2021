{\rtf1\ansi\ansicpg1252\cocoartf2513
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 HelveticaNeue;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 1. +\
SELECT COUNT(id) AS \uc0\u1057 \u1059 \u1052 \u1052 \u1040 \
FROM (SELECT r_id AS id FROM reviews \
      UNION ALL \
      SELECT n_id AS id from news) AS table1\
\
2. +\
\pard\tx560\tx1120\tx1680\tx2240\tx2800\tx3360\tx3920\tx4480\tx5040\tx5600\tx6160\tx6720\pardirnatural\partightenfactor0

\f1\fs26 \cf0 SELECT\
    nc_name,\
    COUNT(n_id)\
FROM\
    news\
RIGHT OUTER JOIN news_categories ON news.n_category = news_categories.nc_id\
GROUP BY nc_id;
\f0\fs24 \
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0
\cf0 \
3. +\
SELECT rc_name, COUNT(r_id)\
FROM reviews\
RIGHT OUTER JOIN reviews_categories ON r_category = rc_id\
GROUP BY rc_id\
\
4. +\
SELECT category_name AS category_name, MAX(dt) FROM (\
SELECT rc_name AS category_name, r_dt AS dt\
FROM reviews_categories\
JOIN reviews ON rc_id = r_category\
UNION ALL\
SELECT nc_name AS category_name, n_dt AS dt\
FROM news_categories\
JOIN news ON nc_id = n_category) AS tb\
GROUP BY category_name\
\
5. +\
SELECT p_name, m2m_banners_pages.b_id, b_url\
FROM pages \
    JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id AND p_parent IS NULL\
    JOIN banners ON banners.b_id = m2m_banners_pages.b_id\
\
6. +\
SELECT DISTINCT p_name\
FROM pages, m2m_banners_pages\
WHERE pages.p_id = m2m_banners_pages.p_id \
\
7. +\
SELECT p_name\
FROM pages\
LEFT JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id \
WHERE m2m_banners_pages.p_id IS NULL\
\
8. +\
SELECT DISTINCT m2m_banners_pages.b_id, b_url\
FROM m2m_banners_pages\
LEFT JOIN banners ON m2m_banners_pages.b_id = banners.b_id\
\
9. +\
SELECT DISTINCT banners.b_id, b_url\
FROM m2m_banners_pages\
RIGHT JOIN banners ON m2m_banners_pages.b_id = banners.b_id\
WHERE m2m_banners_pages.p_id IS NULL\
\
10. +\
SELECT b_id, b_url, b_click/b_show * 100\
FROM banners\
WHERE b_click/b_show > 0.8\
\
11.+\
SELECT DISTINCT p_name\
FROM pages\
LEFT JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id \
LEFT JOIN banners ON banners.b_id = m2m_banners_pages.b_id \
WHERE banners.b_text IS NOT NULL AND pages.p_name IS NOT NULL\
\
12.+\
SELECT DISTINCT p_name\
FROM pages\
LEFT JOIN m2m_banners_pages ON m2m_banners_pages.p_id = pages.p_id \
LEFT JOIN banners ON banners.b_id = m2m_banners_pages.b_id \
WHERE banners.b_pic IS NOT NULL AND pages.p_name IS NOT NULL\
\
13.+\
SELECT n_header, n_dt\
FROM news\
WHERE YEAR(n_dt) < 2012\
UNION ALL\
SELECT r_header, r_dt\
FROM reviews\
WHERE YEAR(r_dt) < 2012\
\
14.+\
SELECT news_categories.nc_name AS category\
FROM news \
RIGHT JOIN news_categories ON nc_id = n_category \
WHERE n_category IS NULL\
UNION\
SELECT reviews_categories.rc_name AS category\
FROM reviews\
RIGHT JOIN reviews_categories ON rc_id = r_category \
WHERE r_category IS NULL\
\
15. +\
SELECT n_header, n_dt\
FROM news\
WHERE YEAR(n_dt) = 2012 AND n_category = 3\
\
16.+\
SELECT YEAR(n_dt) AS yr, COUNT(*)\
FROM news\
GROUP BY yr\
\
17.+\
SELECT banners.b_url, banners.b_id\
FROM(\
    SELECT b_url, Counts\
FROM(\
    SELECT b_url, COUNT(*) AS Counts\
    FROM banners\
GROUP BY(b_url)) AS tabl\
WHERE Counts > 1) AS tabl2\
JOIN banners ON tabl2.b_url = banners.b_url;\
\
18.+\
SELECT p_name, banners.b_id, b_url\
FROM pages\
LEFT JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id\
RIGHT JOIN banners ON banners.b_id = m2m_banners_pages.b_id\
WHERE pages.p_parent = 1\
ORDER BY b_url\
\
19.+\
SELECT b_id, b_url, b_click/b_show\
FROM banners\
WHERE b_pic IS NOT NULL\
ORDER BY b_click/b_show DESC\
\
20. +\
SELECT n_header, n_dt AS dd\
FROM news\
UNION ALL\
SELECT r_header, r_dt AS dd\
FROM reviews\
ORDER BY dd\
LIMIT 1\
\
21.+\
SELECT banners.b_url, banners.b_id\
FROM(\
    SELECT b_url, Counts\
FROM(\
    SELECT b_url, COUNT(*) AS Counts\
    FROM banners\
GROUP BY(b_url)) AS tabl\
WHERE Counts = 1) AS tabl2\
JOIN banners ON tabl2.b_url = banners.b_url;\
\
22.+\
SELECT p_name,COUNT(m2m_banners_pages.b_id) AS cnt\
FROM pages, m2m_banners_pages\
WHERE m2m_banners_pages.p_id = pages.p_id\
GROUP BY p_name\
ORDER BY cnt DESC, p_name;\
\
23.+\
SELECT hh, dd\
FROM(\
    (SELECT n_header AS hh, n_dt AS dd\
        FROM news ORDER BY dd DESC LIMIT 1)) AS tt\
        UNION\
        (SELECT r_header AS hh, r_dt AS dd\
        FROM reviews ORDER BY dd DESC LIMIT 1)\
\
24.+\
SELECT b_id, b_url,b_text\
FROM (SELECT b_id,b_url, b_text, LOCATE(b_text,b_url) AS pos FROM banners) AS tb\
WHERE pos > 1  \
\
25.+\
SELECT p_name\
FROM pages\
    JOIN m2m_banners_pages ON pages.p_id = m2m_banners_pages.p_id\
    JOIN banners ON banners.b_id = m2m_banners_pages.b_id\
ORDER BY (b_click/b_show) DESC\
 LIMIT 1\
\
26.+\
SELECT AVG(b_click/b_show)\
FROM banners\
WHERE b_click > 0\
\
27.+\
SELECT AVG(b_click/b_show)\
FROM banners\
WHERE b_pic IS NULL\
\
28.+\
SELECT COUNT(b_id)\
FROM m2m_banners_pages\
JOIN pages ON m2m_banners_pages.p_id = pages.p_id\
WHERE p_parent IS NULL\
\
29.+\
SELECT banners.b_id, b_url ,COUNT(banners.b_id) AS tb1\
FROM banners, m2m_banners_pages\
WHERE m2m_banners_pages.b_id = banners.b_id\
GROUP BY banners.b_id\
LIMIT 1\
\
30. +\
SELECT p_name, COUNT(m2m_banners_pages.p_id) AS tb1\
FROM pages, m2m_banners_pages\
WHERE pages.p_id = m2m_banners_pages.p_id\
GROUP BY p_name \
ORDER BY tb1 DESC\
LIMIT 2\
\
\
}
