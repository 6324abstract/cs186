-- Q5 Iteration
DROP TABLE IF EXISTS q5_extended_paths;
CREATE TABLE q5_extended_paths(src, dest, length, path)
AS
    SELECT qu.src,qe.dest,qu.length+qe.length as length,path || qe.dest as path
    FROM q5_paths_to_update as qu inner join q5_edges as qe
    on qu.dest=qe.src
    WHERE qu.src<>qe.dest 
;

CREATE TABLE q5_new_paths(src, dest, length, path)
AS
   SELECT qe.src,qe.dest,qe.length,qe.path
   from q5_extended_paths qe
   inner join q5_paths as q
    on q.src=qe.src and(q.dest<>qe.dest or q.length>qe.length);

CREATE TABLE q5_better_paths(src, dest, length, path)
AS 
    SELECT q.src,q.dest,
    case  when q.length<qe.length then q.length else qe.length end as length,
    case  when q.length<qe.length then q.path else qe.path end as path
    from q5_paths q inner join q5_new_paths as qe
    on q.src=qe.src and q.dest=qe.dest;
    
    

DROP TABLE q5_paths;
ALTER TABLE q5_better_paths RENAME TO q5_paths;

DROP TABLE q5_paths_to_update;
ALTER TABLE q5_new_paths RENAME TO q5_paths_to_update;

SELECT COUNT(*) AS path_count,
       CASE WHEN 0 = (SELECT COUNT(*) FROM q5_paths_to_update) 
            THEN 'FINISHED'
            ELSE 'RUN AGAIN' END AS status
  FROM q5_paths;
