-- 1. What grades are stored in the database?

SELECT *
FROM Grade;

-- 2. What emotions may be associated with a poem?

SELECT *
FROM Emotion;

-- 3. How many poems are in the database?

SELECT COUNT(Poem.Id) AS 'Amount of Poems'
FROM Poem;

-- 4. Sort authors alphabetically by name. What are the names of the top 76 authors?

SELECT TOP 76 Name
FROM AUTHOR 
ORDER BY Author.Name ASC;

-- 5. Starting with the above query, add the grade of each of the authors. 

SELECT TOP 76 a.Name as 'Author Name', g.Name as 'Author Grade'
FROM AUTHOR a 
JOIN Grade g ON g.Id = a.GradeId
ORDER BY a.Name ASC;

-- 6. Starting with the above query, add the recorded gender of each of the authors.

SELECT TOP 76 a.Name as 'Author Name', g.Name as 'Author Grade', ge.Name as 'Gender' 
FROM AUTHOR a 
JOIN Grade g ON g.Id = a.GradeId
JOIN Gender ge ON ge.Id = a.GenderId
ORDER BY a.Name ASC;

-- 7. What is the total number of words in all poems in the database?

SELECT SUM(Poem.WordCount) as 'Total Words'
FROM Poem

-- 8. Which poem has the fewest characters?

SELECT TOP 1 p.Title as 'Poem Name', p.CharCount as 'Lowest Character Count'
FROM Poem p
ORDER BY p.CharCount ASC;

-- 9. How many authors are in the third grade?

SELECT COUNT(a.Id) as '3rd Grade Authors'
FROM Author a
JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '3rd Grade';

-- 10. How many total authors are in the first through third grades?

SELECT COUNT(a.Id) as '1st-3rd Grade Authors'
FROM Author a
JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '3rd Grade' OR g.Name = '1st Grade' OR g.Name = '2nd Grade';

-- 11. What is the total number of poems written by fourth graders?

SELECT COUNT(Poem.Id) as 'Poems by fourth graders'
FROM Poem 
JOIN Author a ON a.Id = Poem.AuthorId
JOIN Grade g ON g.Id = a.GradeId
WHERE g.Name = '4th Grade';

-- 12. How many poems are there per grade?

SELECT g.Name as 'Grade', COUNT(g.Id) 'Number of Poems'
FROM Poem 
JOIN Author a ON a.Id = Poem.AuthorId
JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Name;

-- 13. How many authors are in each grade? (Order your results by grade starting with 1st Grade)

SELECT g.Name, COUNT(g.Id) as 'Number of Authors'
FROM Author a
JOIN Grade g ON g.Id = a.GradeId
GROUP BY g.Name;

-- 14. What is the title of the poem that has the most words?

SELECT TOP 1 p.WordCount, p.Title
FROM Poem p
ORDER BY p.WordCount DESC;

-- 15. Which author(s) have the most poems? (Remember authors can have the same name.)

SELECT a.Name, a.Id, COUNT(a.Id) as 'Number of Poems'
FROM Poem p
JOIN Author a ON a.Id = p.AuthorId
GROUP BY a.Id, a.Name 
ORDER BY COUNT(a.Id) DESC;

-- 16. How many poems have an emotion of sadness?

SELECT e.Name as 'Poem Emotion', COUNT(e.Id) as 'Number of sad Poems'
FROM PoemEmotion pe
JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'sadness'
GROUP BY e.Name;

-- 17. How many poems are not associated with any emotion?

SELECT Count(p.Id) as 'World of emptiness'
FROM PoemEmotion pe
RIGHT JOIN Poem p ON p.Id = pe.PoemId
WHERE pe.PoemId IS NULL;

-- 18.  Which emotion is associated with the least number of poems?

SELECT TOP 1 COUNT(e.id) '# of Poems', e.Name
FROM PoemEmotion pe
JOIN Emotion e ON e.Id = pe.EmotionId 
GROUP BY e.Name;

-- 19. Which grade has the largest number of poems with an emotion of joy?

SELECT TOP 1 COUNT(p.Id) as 'Number of Poems', g.Name
FROM Grade g
JOIN Author a ON a.GradeId = g.Id
JOIN Poem p ON p.AuthorId = a.Id
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON e.Id = pe.EmotionId
WHERE e.Name = 'Joy'
GROUP BY g.Name
ORDER BY g.Name DESC;

-- 20. Which gender has the least number of poems with an emotion of fear?

SELECT TOP 1 COUNT(e.Id) AS '# Of Fear Poems', g.Name as 'Gender'
FROM Gender g
JOIN Author a ON a.GenderId = g.Id
JOIN Poem p ON p.AuthorId = a.Id
JOIN PoemEmotion pe ON pe.PoemId = p.Id
JOIN Emotion e ON e.id = pe.EmotionId
WHERE e.Name = 'fear'
GROUP BY g.Name
ORDER BY COUNT(e.Id) ASC;






