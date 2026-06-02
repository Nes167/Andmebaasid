<img width="688" height="646" alt="{7BB9B2BC-16C9-47F9-A570-1957360C48CB}" src="https://github.com/user-attachments/assets/74cb94cd-81ed-487c-906e-9ca82172a75f" />

```sql
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(),
'on tehtud INSERT käsk', 
concat('linn: ', NEW.linnanimi, ', rahvaarv: ', NEW.rahvaarv)
FROM linnad
WHERE linnad.linnID=NEW.linnID;
```


<img width="685" height="679" alt="{EB407655-A5F5-40F4-BBD3-BAAEEB3DFEAE}" src="https://github.com/user-attachments/assets/90ad7034-3e46-43c5-b8d2-4eb59f173cf2" />

```sql
INSERT INTO logi(kuupaev, kasutaja, toiming, andmed)
SELECT
NOW(),
USER(), 
'on tehtud DELETE käsk',  
concat('linn: ', OLD.linnanimi, ', rahvaarv: ', OLD.rahvaarv)
FROM linnad
WHERE linnad.linnID=OLD.linnID
```



