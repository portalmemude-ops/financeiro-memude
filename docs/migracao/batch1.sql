BEGIN;
DELETE FROM transactions WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM settlements WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM payables WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM receivables WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM commission_installments WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM commissions WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM sales WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('f4e2e4ab-c5aa-429f-9336-6f6b2774a3f4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Amazon', 'Amazon', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('43a127e1-24fd-4f56-8ad9-8e49939965c8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Meta', 'Meta', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('550e7f95-39e9-4c1e-843a-41fb79f962fa', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Google', 'Google', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('2a1ede6d-1df1-4ee5-8e36-b4782683da26', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Mercado Livre', 'Mercado Livre', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('ea53d9ed-19d6-4504-8abf-34f7376becb8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Reno', 'Reno', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('d1069f67-12e7-4ea0-85da-a339c4c195da', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Angélica', 'Angélica', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('f8d56c53-a2a4-41c2-9372-7c9560332cf4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'CE Placas', 'CE Placas', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('96a253df-5a0e-4185-9969-c2dee94de1a5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'CFCI', 'CFCI', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('afdfc56a-6c1d-4e88-aa3e-f3b5f41c70dc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bruno', 'Bruno', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('9a1ef9d8-82c0-407c-b586-b9e0cfb3cb1a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Felipe', 'Felipe', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('8b26015a-c9f3-446a-9530-f47757f532da', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pedro', 'Pedro', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('6d5fa8f9-a5c5-41bd-9544-a64d7ad7dd82', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Souza', 'Souza', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('341f3191-5254-4400-b763-2e3071276044', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Receita Federal', 'Receita Federal', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('dda47ddf-192c-41a3-a51c-9764c633bd29', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Assis', 'Assis', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('71aa990e-85e6-4fff-b79d-7e5aac40a20d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Nummis', 'Nummis', TRUE)
    ON CONFLICT DO NOTHING;
  

    INSERT INTO suppliers (id, company_id, legal_name, trade_name, is_active)
    VALUES ('a4c8fd3c-922c-40c0-9931-c3874ce50de8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Contador', 'Contador', TRUE)
    ON CONFLICT DO NOTHING;
  
COMMIT;