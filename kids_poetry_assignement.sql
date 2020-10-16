--The poetry in this database is the work of children in grades 1 through 5.
--a. How many poets from each grade are represented in the data?
Select count(id)
from public.author
where grade_id between 1 and 5

Select count(au.id, gr.name)
from public.author au 
Left join public.grade gr on au.name = gr.name

SELECT A.name AS Name, B.id AS ID
FROM public.author A, public.grade B
WHERE A.id <> B.id
AND A.id = B.id
ORDER BY A.Name;


--b.  How many of the poets in each grade are Male and how many are Female? Only return 
--the poets identified as Male or Female.
SELECT *
FROM (
    SELECT * FROM public.author
) sub1
LEFT JOIN (
    SELECT * FROM public.gender
) sub2 ON sub1.id = sub2.id
WHere sub2.name Like 'Female'


--#2-Love and death have been popular themes in poetry throughout time. 
--Which of these things do children write about more often?
--Which do they have the most to say about when they do? Return the total number of poems,
--their average character count for poems that mention death and poems that mention love. 
--Do this in a single query.

SELECT *
FROM (
    SELECT * FROM public.poem
) sub1
LEFT JOIN (
    SELECT * FROM public.author
) sub2 ON sub1.author_id = sub2.id
WHere sub1.title IN ('Love', 'death') 
order by char_count Desc

#3a--Do longer poems have more emotional intensity compared to shorter poems?
--a. Start by writing a query to return each emotion in the database with it's average intensity and character count.

--Which emotion is associated the longest poems on average?
--Which emotion has the shortest?
SELECT *
FROM (
    SELECT * FROM public.emotion
) sub1
LEFT JOIN (
    SELECT * FROM public.poem_emotion order by intensity_percent desc
) sub2 ON sub1.id = sub2.id
--WHere sub1.intensity_percent IN ('Love', 'death') 
order by intensity_percent Desc

--b.  Convert the query you wrote in part a into a CTE. Then find the 5 most intense poems that
--express joy and whether 
--they are to be longer or shorter than the average joy poem.

--What is the most joyful poem about?
--Do you think these are all classified correctly?

SELECT *
FROM (
    SELECT * FROM public.Poem
) sub1
Left JOIN (
    SELECT * FROM public.emotion
) sub2 ON sub1.id = sub2.id

Left JOIN (
    SELECT * FROM public.author
) sub3 ON sub2.id = sub3.id

Left JOIN (
    SELECT * FROM public.poem_emotion 
) sub4 ON sub3.id = sub4.id
WHere sub2.name IN ('Joy') 
order by intensity_percent Desc

--#4 Compare the 5 most angry poems by 1st graders to the 5 most angry poems by 5th graders.

--a. Which group writes the angreist poems according to the intensity score?
--b. Who shows up more in the top five for grades 1 and 5, males or females?
--c. Which of these do you like the best?

SELECT *
FROM (
    SELECT * FROM public.Poem
) sub1
Left JOIN (
    SELECT * FROM public.emotion
) sub2 ON sub1.id = sub2.id

Left JOIN (
    SELECT * FROM public.author
) sub3 ON sub2.id = sub3.id

Right JOIN (
    SELECT * FROM public.grade
) sub4 ON sub3.id = sub4.id
WHere sub3.grade_id = 1

--SELECT *
--FROM (
 --   SELECT * FROM public.grade
--) sub1
--Left JOIN (
  --  SELECT * FROM public.author
--) sub2 ON sub1.id = sub2.id

--Left JOIN (
  --  SELECT * FROM public.emotion
--) sub3 ON sub2.id = sub3.id

--Right JOIN (
  --  SELECT * FROM public.poem_emotion
--) sub4 ON sub3.id = sub4.id
 
--order by intensity_percent Desc
