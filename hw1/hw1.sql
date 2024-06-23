DROP VIEW IF EXISTS q0, q1i, q1ii, q1iii, q1iv, q2i, q2ii, q2iii, q3i, q3ii, q3iii, q4i, q4ii, q4iii, q4iv;

-- Question 0
CREATE VIEW q0(era) 
AS
  SELECT MAX(era) -- replace this line
  from pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear -- replace this line
  from master
  where weight>300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  SELECT namefirst, namelast, birthyear FROM master WHERE namefirst LIKE '% %';
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  SELECT birthyear,
         AVG(height) AS avgheight,
         COUNT(*) AS count
  FROM master GROUP BY birthyear
  ORDER BY birthyear ASC
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  SELECT birthyear,AVG(height) as avgheight,COUNT(*) as count
  from master group by birthyear
  having AVG(height)>70
  ORDER BY birthyear asc
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  SELECT namefirst, namelast, master.playerid, yearid -- replace this line
  from master inner join halloffame    on master.playerid = halloffame.playerid where halloffame.inducted = 'Y'
  order by yearid desc
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  SELECT namefirst, namelast, h.playerid, cp.schoolid, h.yearid -- replace this line
  from master m inner join halloffame h on m.playerid=h.playerid 
  inner join collegeplaying cp on m.playerid=cp.playerid
  inner join schools s on cp.schoolid=s.schoolid
  where h.inducted = 'Y' and s.schoolstate='CA'
  order by h.yearid desc,cp.schoolid asc,playerid asc

;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  select h.playerid,namefirst,namelast,cp.schoolid
  from master m inner join halloffame h on m.playerid=h.playerid
  left outer  join collegeplaying cp on m.playerid=cp.playerid
  left outer join schools s on cp.schoolid=s.schoolid
  where h.inducted='Y' 
  order by h.playerid desc, cp.schoolid asc
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
   SELECT m.playerid,
         m.namefirst,
         m.namelast,
         b.yearid,
         (b.h - b.h2b - b.h3b - b.hr + 2*b.h2b + 3*b.h3b + 4*b.hr) 
                / (cast(b.ab as real)) AS slg
  FROM master AS m INNER JOIN batting as b ON m.playerid = b.playerid
  WHERE b.ab > 50
  ORDER BY slg DESC, b.yearid, m.playerid ASC
  LIMIT 10
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  SELECT b.yearid,m.playerid,m.namefirst,m.namelast,  sum(b.h - b.h2b - b.h3b - b.hr + 2*b.h2b + 3*b.h3b + 4*b.hr) 
                / (cast(sum(b.ab) as real)) AS lslg
FROM master AS m INNER JOIN batting as b ON m.playerid = b.playerid
group by  b.yearid,m.playerid
having sum(b.ab)>50
order by lslg desc, m.playerid asc
limit 10
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  with willie as (
    select sum(b.h - b.h2b - b.h3b - b.hr + 2*b.h2b + 3*b.h3b + 4*b.hr) 
                / (cast(sum(b.ab) as real)) as lslg
    from batting as b
    where b.playerid ='mayswi01'
    group by b.playerid)
  SELECT namefirst,namelast, sum(b.h - b.h2b - b.h3b - b.hr + 2*b.h2b + 3*b.h3b + 4*b.hr) 
                / (cast(sum(b.ab) as real)) AS lslg
  from master m inner join batting b on m.playerid=b.playerid
  group by m.playerid
  having sum(b.ab)>50
  and  sum(b.h - b.h2b - b.h3b - b.hr + 2*b.h2b + 3*b.h3b + 4*b.hr) 
                / (cast(sum(b.ab) as real))>(select lslg from willie)
; 

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg, stddev)
AS
  select yearid,min(salary),max(salary),avg(salary),stddev(salary) from salaries
  group by yearid
  order by yearid asc
;

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;