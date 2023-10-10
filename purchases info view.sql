CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `purchases_info` AS
    SELECT 
        `365_student_purchases`.`purchase_id` AS `purchase_id`,
        `365_student_purchases`.`student_id` AS `student_id`,
        `365_student_purchases`.`purchase_type` AS `purchase_type`,
        `365_student_purchases`.`date_purchased` AS `date_start`,
        (CASE
            WHEN (`365_student_purchases`.`purchase_type` = 'Monthly') THEN (`365_student_purchases`.`date_purchased` + INTERVAL 1 MONTH)
            WHEN (`365_student_purchases`.`purchase_type` = 'Quarterly') THEN (`365_student_purchases`.`date_purchased` + INTERVAL 3 MONTH)
            WHEN (`365_student_purchases`.`purchase_type` = 'Annual') THEN (`365_student_purchases`.`date_purchased` + INTERVAL 1 YEAR)
        END) AS `date_end`
    FROM
        `365_student_purchases`