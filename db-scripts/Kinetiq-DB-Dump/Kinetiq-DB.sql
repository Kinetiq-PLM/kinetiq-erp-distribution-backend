--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: accounting; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA accounting;


ALTER SCHEMA accounting OWNER TO postgres;

--
-- Name: admin; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA admin;


ALTER SCHEMA admin OWNER TO postgres;

--
-- Name: distribution; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA distribution;


ALTER SCHEMA distribution OWNER TO postgres;

--
-- Name: finance; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA finance;


ALTER SCHEMA finance OWNER TO postgres;

--
-- Name: human_resources; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA human_resources;


ALTER SCHEMA human_resources OWNER TO postgres;

--
-- Name: inventory; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA inventory;


ALTER SCHEMA inventory OWNER TO postgres;

--
-- Name: management; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA management;


ALTER SCHEMA management OWNER TO postgres;

--
-- Name: mrp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mrp;


ALTER SCHEMA mrp OWNER TO postgres;

--
-- Name: operations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA operations;


ALTER SCHEMA operations OWNER TO postgres;

--
-- Name: production; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA production;


ALTER SCHEMA production OWNER TO postgres;

--
-- Name: project_management; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA project_management;


ALTER SCHEMA project_management OWNER TO postgres;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- Name: purchasing; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA purchasing;


ALTER SCHEMA purchasing OWNER TO postgres;

--
-- Name: sales; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA sales;


ALTER SCHEMA sales OWNER TO postgres;

--
-- Name: services; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA services;


ALTER SCHEMA services OWNER TO postgres;

--
-- Name: solution_customizing; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA solution_customizing;


ALTER SCHEMA solution_customizing OWNER TO postgres;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: access_level; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.access_level AS ENUM (
    'Full Access',
    'Read-Only'
);


ALTER TYPE public.access_level OWNER TO postgres;

--
-- Name: adjustment_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.adjustment_type_enum AS ENUM (
    'Inbound',
    'Outbound-Distribution',
    'Outbound-Production',
    'Outbound-Deprecated'
);


ALTER TYPE public.adjustment_type_enum OWNER TO postgres;

--
-- Name: agreement_method_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.agreement_method_enum AS ENUM (
    'Written',
    'Oral',
    'Electronic'
);


ALTER TYPE public.agreement_method_enum OWNER TO postgres;

--
-- Name: agreement_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.agreement_status_enum AS ENUM (
    'Active',
    'Expired',
    'Cancelled',
    'Planned'
);


ALTER TYPE public.agreement_status_enum OWNER TO postgres;

--
-- Name: approval_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.approval_status_type AS ENUM (
    'Pending',
    'Approved',
    'Rejected'
);


ALTER TYPE public.approval_status_type OWNER TO postgres;

--
-- Name: availability_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.availability_status AS ENUM (
    'Available',
    'Out of Order',
    'Under Maintenance'
);


ALTER TYPE public.availability_status OWNER TO postgres;

--
-- Name: campaign_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.campaign_status_enum AS ENUM (
    'Planned',
    'Active',
    'Completed'
);


ALTER TYPE public.campaign_status_enum OWNER TO postgres;

--
-- Name: campaign_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.campaign_type_enum AS ENUM (
    'Email',
    'SMS',
    'Referral'
);


ALTER TYPE public.campaign_type_enum OWNER TO postgres;

--
-- Name: completion_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.completion_status_enum AS ENUM (
    'Open',
    'Partially Delivered',
    'Completed',
    'Cancelled',
    'Pending Approval',
    'Project Ongoing'
);


ALTER TYPE public.completion_status_enum OWNER TO postgres;

--
-- Name: customer_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.customer_type_enum AS ENUM (
    'Lead',
    'Prospect',
    'Client'
);


ALTER TYPE public.customer_type_enum OWNER TO postgres;

--
-- Name: delivery_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.delivery_status_enum AS ENUM (
    'Pending',
    'Shipped',
    'Delivered',
    'Returned',
    'Failed'
);


ALTER TYPE public.delivery_status_enum OWNER TO postgres;

--
-- Name: demand_level_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.demand_level_enum AS ENUM (
    'Low',
    'Medium',
    'High',
    'Very High',
    'Seasonal'
);


ALTER TYPE public.demand_level_enum OWNER TO postgres;

--
-- Name: document_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.document_type_enum AS ENUM (
    'Goods Receipt PO',
    'Goods Issue',
    'Goods Receipt',
    'A/R Credit Memo'
);


ALTER TYPE public.document_type_enum OWNER TO postgres;

--
-- Name: employment_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.employment_type AS ENUM (
    'fixed-term',
    'temporary employment',
    'freelance',
    'internships'
);


ALTER TYPE public.employment_type OWNER TO postgres;

--
-- Name: ext_modules; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ext_modules AS ENUM (
    'Accounting',
    'Admin',
    'Distribution',
    'Finance',
    'Human Resources',
    'Inventory',
    'Management',
    'MRP',
    'Operations',
    'Production',
    'Project Management',
    'Purchasing',
    'Sales',
    'Services',
    'Solution Customizing'
);


ALTER TYPE public.ext_modules OWNER TO postgres;

--
-- Name: inspection_result; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.inspection_result AS ENUM (
    'Pass',
    'Fail'
);


ALTER TYPE public.inspection_result OWNER TO postgres;

--
-- Name: interest_level_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.interest_level_enum AS ENUM (
    'Low',
    'Medium',
    'High',
    'Very High'
);


ALTER TYPE public.interest_level_enum OWNER TO postgres;

--
-- Name: internal_external_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.internal_external_type AS ENUM (
    'Internal Delivery',
    'External Delivery'
);


ALTER TYPE public.internal_external_type OWNER TO postgres;

--
-- Name: intrnl_project_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.intrnl_project_status AS ENUM (
    'not started',
    'in progress',
    'completed'
);


ALTER TYPE public.intrnl_project_status OWNER TO postgres;

--
-- Name: intrnl_task_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.intrnl_task_status AS ENUM (
    'pending',
    'in_progress',
    'completed',
    'canceled'
);


ALTER TYPE public.intrnl_task_status OWNER TO postgres;

--
-- Name: inventory_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.inventory_status AS ENUM (
    'Open',
    'In Progress',
    'Completed',
    'Closed',
    'Cancelled'
);


ALTER TYPE public.inventory_status OWNER TO postgres;

--
-- Name: inventory_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.inventory_status_enum AS ENUM (
    'Pending',
    'Approved',
    'Rejected'
);


ALTER TYPE public.inventory_status_enum OWNER TO postgres;

--
-- Name: inventory_time_period; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.inventory_time_period AS ENUM (
    'weekly',
    'monthly',
    'quarterly',
    'yearly'
);


ALTER TYPE public.inventory_time_period OWNER TO postgres;

--
-- Name: invoice_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.invoice_status_enum AS ENUM (
    'Pending',
    'Paid',
    'Overdue'
);


ALTER TYPE public.invoice_status_enum OWNER TO postgres;

--
-- Name: item_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.item_status_enum AS ENUM (
    'On Order',
    'Committed',
    'Available'
);


ALTER TYPE public.item_status_enum OWNER TO postgres;

--
-- Name: item_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.item_type AS ENUM (
    'Raw Material',
    'Asset',
    'Product'
);


ALTER TYPE public.item_type OWNER TO postgres;

--
-- Name: manage_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.manage_type AS ENUM (
    'None',
    'Serial Number',
    'Batches'
);


ALTER TYPE public.manage_type OWNER TO postgres;

--
-- Name: management_approval_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.management_approval_status AS ENUM (
    'approved',
    'pending',
    'rejected'
);


ALTER TYPE public.management_approval_status OWNER TO postgres;

--
-- Name: notifications_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.notifications_status_enum AS ENUM (
    'Read',
    'Unread',
    'Archived'
);


ALTER TYPE public.notifications_status_enum OWNER TO postgres;

--
-- Name: operations_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.operations_status_enum AS ENUM (
    'Open',
    'Closed',
    'Cancelled',
    'Draft'
);


ALTER TYPE public.operations_status_enum OWNER TO postgres;

--
-- Name: opportunity_stage_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.opportunity_stage_enum AS ENUM (
    'Prospecting',
    'Negotiation',
    'Closed'
);


ALTER TYPE public.opportunity_stage_enum OWNER TO postgres;

--
-- Name: opportunity_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.opportunity_status_enum AS ENUM (
    'Open',
    'Won',
    'Lost'
);


ALTER TYPE public.opportunity_status_enum OWNER TO postgres;

--
-- Name: order_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status_enum AS ENUM (
    'Pending',
    'Processed',
    'Shipped',
    'Delivered',
    'Cancelled'
);


ALTER TYPE public.order_status_enum OWNER TO postgres;

--
-- Name: order_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_status_type AS ENUM (
    'Created',
    'Approved',
    'Rejected'
);


ALTER TYPE public.order_status_type OWNER TO postgres;

--
-- Name: order_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.order_type_enum AS ENUM (
    'Non-Project-Based',
    'Project-Based',
    'Service'
);


ALTER TYPE public.order_type_enum OWNER TO postgres;

--
-- Name: organization_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.organization_type_enum AS ENUM (
    'Corporation',
    'LLC',
    'Sole Proprietorship',
    'Partnership',
    'Nonprofit'
);


ALTER TYPE public.organization_type_enum OWNER TO postgres;

--
-- Name: packing_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.packing_status_type AS ENUM (
    'Pending',
    'Packed',
    'Shipped'
);


ALTER TYPE public.packing_status_type OWNER TO postgres;

--
-- Name: packing_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.packing_type_enum AS ENUM (
    'Box',
    'Bubble Wrap',
    'Crate'
);


ALTER TYPE public.packing_type_enum OWNER TO postgres;

--
-- Name: partner_category; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.partner_category AS ENUM (
    'Employee',
    'Customer',
    'Vendor'
);


ALTER TYPE public.partner_category OWNER TO postgres;

--
-- Name: payment_method_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_method_enum AS ENUM (
    'Credit Card',
    'Bank Transfer',
    'Cash'
);


ALTER TYPE public.payment_method_enum OWNER TO postgres;

--
-- Name: payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status_enum AS ENUM (
    'Unpaid',
    'Partially Paid',
    'Fully Paid',
    'Returned'
);


ALTER TYPE public.payment_status_enum OWNER TO postgres;

--
-- Name: picked_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.picked_status_type AS ENUM (
    'Not Started',
    'In Progress',
    'Completed'
);


ALTER TYPE public.picked_status_type OWNER TO postgres;

--
-- Name: prod_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.prod_status AS ENUM (
    'Pending',
    'In Progress',
    'Completed',
    'Cancelled'
);


ALTER TYPE public.prod_status OWNER TO postgres;

--
-- Name: project_based_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.project_based_type AS ENUM (
    'Project Based',
    'Non-Project Based'
);


ALTER TYPE public.project_based_type OWNER TO postgres;

--
-- Name: project_budget_approval; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.project_budget_approval AS ENUM (
    'approved',
    'denied'
);


ALTER TYPE public.project_budget_approval OWNER TO postgres;

--
-- Name: project_milestone; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.project_milestone AS ENUM (
    'planning',
    'awaiting_approval',
    'manufacturing',
    'deployment',
    'installation',
    'completed'
);


ALTER TYPE public.project_milestone OWNER TO postgres;

--
-- Name: project_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.project_status AS ENUM (
    'not started',
    'in progress',
    'completed'
);


ALTER TYPE public.project_status OWNER TO postgres;

--
-- Name: project_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.project_status_enum AS ENUM (
    'Approved',
    'Pending',
    'Rejected',
    'In Progress',
    'Completed'
);


ALTER TYPE public.project_status_enum OWNER TO postgres;

--
-- Name: project_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.project_type AS ENUM (
    'plans',
    'changes',
    'trainings'
);


ALTER TYPE public.project_type OWNER TO postgres;

--
-- Name: purchase_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.purchase_status AS ENUM (
    'Pending',
    'Approved',
    'Rejected',
    'Completed'
);


ALTER TYPE public.purchase_status OWNER TO postgres;

--
-- Name: quotation_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.quotation_status_enum AS ENUM (
    'Pending',
    'Approved',
    'Expired'
);


ALTER TYPE public.quotation_status_enum OWNER TO postgres;

--
-- Name: quotation_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.quotation_type_enum AS ENUM (
    'Project-Based',
    'Non-Project-Based',
    'Service'
);


ALTER TYPE public.quotation_type_enum OWNER TO postgres;

--
-- Name: receipt_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.receipt_status_type AS ENUM (
    'Pending',
    'Received',
    'Rejected'
);


ALTER TYPE public.receipt_status_type OWNER TO postgres;

--
-- Name: receiving_module_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.receiving_module_enum AS ENUM (
    'Inventory',
    'Production'
);


ALTER TYPE public.receiving_module_enum OWNER TO postgres;

--
-- Name: rejection_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.rejection_status_type AS ENUM (
    'Pending',
    'Confirmed',
    'Resolved'
);


ALTER TYPE public.rejection_status_type OWNER TO postgres;

--
-- Name: report_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.report_type AS ENUM (
    'Sales Order',
    'Resource Availability',
    'Bill of Material',
    'Information',
    'Progress Report',
    'Project Details'
);


ALTER TYPE public.report_type OWNER TO postgres;

--
-- Name: request_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.request_type AS ENUM (
    'Material Request',
    'Finished Goods Request'
);


ALTER TYPE public.request_type OWNER TO postgres;

--
-- Name: resolution_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.resolution_status_type AS ENUM (
    'Pending',
    'Resolved'
);


ALTER TYPE public.resolution_status_type OWNER TO postgres;

--
-- Name: response_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.response_status_enum AS ENUM (
    'Interested',
    'Not Interested',
    'Pending'
);


ALTER TYPE public.response_status_enum OWNER TO postgres;

--
-- Name: return_action; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.return_action AS ENUM (
    'Credit',
    'Repair',
    'Replace',
    'Return',
    'Define New'
);


ALTER TYPE public.return_action OWNER TO postgres;

--
-- Name: return_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.return_status AS ENUM (
    'Success',
    'Failed',
    'Pending'
);


ALTER TYPE public.return_status OWNER TO postgres;

--
-- Name: rework_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.rework_status_type AS ENUM (
    'Pending',
    'In Progress',
    'Completed'
);


ALTER TYPE public.rework_status_type OWNER TO postgres;

--
-- Name: rework_types_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.rework_types_type AS ENUM (
    'Rejection',
    'Failed Shipment'
);


ALTER TYPE public.rework_types_type OWNER TO postgres;

--
-- Name: service_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.service_type_enum AS ENUM (
    'Standard',
    'Express',
    'Same-day'
);


ALTER TYPE public.service_type_enum OWNER TO postgres;

--
-- Name: shelf_life_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shelf_life_enum AS ENUM (
    'Depreciating',
    'Expiring'
);


ALTER TYPE public.shelf_life_enum OWNER TO postgres;

--
-- Name: shipment_status_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shipment_status_type AS ENUM (
    'Failed',
    'Pending',
    'Shipped',
    'Delivered'
);


ALTER TYPE public.shipment_status_type OWNER TO postgres;

--
-- Name: shipping_method_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.shipping_method_enum AS ENUM (
    'Standard',
    'Express',
    'Overnight',
    'Same-Day',
    'International',
    'Local'
);


ALTER TYPE public.shipping_method_enum OWNER TO postgres;

--
-- Name: single_payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.single_payment_status_enum AS ENUM (
    'Pending',
    'Completed',
    'Failed'
);


ALTER TYPE public.single_payment_status_enum OWNER TO postgres;

--
-- Name: status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.status_enum AS ENUM (
    'Active',
    'Inactive',
    'Blocked'
);


ALTER TYPE public.status_enum OWNER TO postgres;

--
-- Name: task_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.task_status AS ENUM (
    'pending',
    'in_progress',
    'completed',
    'canceled'
);


ALTER TYPE public.task_status OWNER TO postgres;

--
-- Name: ticket_priority_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ticket_priority_enum AS ENUM (
    'Low',
    'Medium',
    'High',
    'Urgent'
);


ALTER TYPE public.ticket_priority_enum OWNER TO postgres;

--
-- Name: ticket_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ticket_status_enum AS ENUM (
    'Open',
    'In Progress',
    'Closed'
);


ALTER TYPE public.ticket_status_enum OWNER TO postgres;

--
-- Name: ticket_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ticket_type_enum AS ENUM (
    'Sales',
    'Service'
);


ALTER TYPE public.ticket_type_enum OWNER TO postgres;

--
-- Name: unit_of_measure; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.unit_of_measure AS ENUM (
    'kg',
    'sh',
    'bx',
    'L',
    'm',
    'gal',
    'pcs',
    'set',
    'mm',
    'unit'
);


ALTER TYPE public.unit_of_measure OWNER TO postgres;

--
-- Name: user_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status AS ENUM (
    'Active',
    'Inactive'
);


ALTER TYPE public.user_status OWNER TO postgres;

--
-- Name: user_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_type AS ENUM (
    'Customer',
    'Employee'
);


ALTER TYPE public.user_type OWNER TO postgres;

--
-- Name: vendor_application_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vendor_application_status AS ENUM (
    'Pending',
    'Approved',
    'Rejected'
);


ALTER TYPE public.vendor_application_status OWNER TO postgres;

--
-- Name: yes_no_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.yes_no_type AS ENUM (
    'Yes',
    'No'
);


ALTER TYPE public.yes_no_type OWNER TO postgres;

--
-- Name: create_journal_entry_for_ar_credit_memo(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_ar_credit_memo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_journal_id VARCHAR(255);
    v_transaction_cost DECIMAL(18,2);
    v_account_name VARCHAR(255);
    v_gl_account_id VARCHAR(255);
BEGIN
    -- Check if the document type is 'A/R Credit Memo'
    IF (SELECT document_type FROM operations.document_header WHERE document_id = NEW.document_id) = 'A/R Credit Memo' THEN

                -- Get the corresponding gl_account_id and account_name for the vendor
        SELECT gl_account_id, account_name
        INTO v_gl_account_id, v_account_name
        FROM accounting.general_ledger_accounts
        WHERE account_id = NEW.vendor_code;

        SELECT transaction_cost INTO v_transaction_cost
        FROM operations.document_header
        WHERE document_id = NEW.document_id;


        -- Insert into journal_entries
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (CURRENT_DATE, 'A/R Credit Memo', v_transaction_cost, v_transaction_cost, NEW.document_id, NULL)
        RETURNING journal_id INTO v_journal_id;

     
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, 
                (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-RR4030'), 
              v_transaction_cost,   0, 
                'Sales Return');
             
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, v_gl_account_id, 0, v_transaction_cost,  v_account_name);  

    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_ar_credit_memo() OWNER TO postgres;

--
-- Name: create_journal_entry_for_budget_allocation(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_budget_allocation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_journal_id VARCHAR(255);
    v_entry_line_id VARCHAR(255);
    v_credit_account VARCHAR(255);
    v_dept_name VARCHAR(100);
    currency_id VARCHAR(255) := NULL;
BEGIN
     IF NEW.status = 'final' THEN

    -- Get department name from finance.budget_submission
    SELECT dept_name INTO v_dept_name 
    FROM human_resources.departments 
    WHERE dept_id = (SELECT dept_id FROM finance.budget_submission WHERE budget_submission_id = NEW.budget_submission_id);

    -- Determine Credit Account based on department
    v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - ' || v_dept_name);

    -- Insert Journal Entry
    INSERT INTO accounting.journal_entries ( journal_date, description, total_debit, total_credit, invoice_id, currency_id)
    VALUES ( CURRENT_DATE, 'Budget Allocation for ' || v_dept_name, NEW.total_budget, NEW.total_budget, NEW.budget_allocation_id, currency_id)
    RETURNING journal_id INTO v_journal_id;

    -- Insert Debit Entry (Encumbrance Control)
    INSERT INTO accounting.journal_entry_lines ( journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES ( v_journal_id, 
            (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-IB8020' AND account_name = 'Encumbrance Control'), 
            NEW.total_budget, 0, 'Encumbrance Control');

    -- Insert Credit Entry (Budgetary Control)
    INSERT INTO accounting.journal_entry_lines ( journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES ( v_journal_id, v_credit_account, 0, NEW.total_budget, 'Budgetary Control - ' || v_dept_name);
         
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_budget_allocation() OWNER TO postgres;

--
-- Name: create_journal_entry_for_budget_return(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_budget_return() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_journal_id VARCHAR(255);
    v_entry_line_id VARCHAR(255);
    v_credit_account VARCHAR(255);
    v_dept_name VARCHAR(100);
    currency_id VARCHAR(255) := NULL;
BEGIN
  

    -- Get department name
    SELECT dept_name INTO v_dept_name FROM human_resources.departments WHERE dept_id = NEW.dept_id;

    -- Determine Credit Account based on department
    CASE v_dept_name
        WHEN 'Accounting' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Accounting');
WHEN 'Administration' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Administration');
WHEN 'Distribution' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Distribution');
WHEN 'Finance' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Finance');
WHEN 'Human Resource' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Human Resource');
WHEN 'Inventory' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Inventory');
WHEN 'Management' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Management');
WHEN 'Material Resource Planning' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Material Resource Planning');
WHEN 'Operations' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Operations');
WHEN 'Production' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Production');
WHEN 'Project Management' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Project Management');
WHEN 'Purchasing' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Purchasing');
WHEN 'Sales' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Sales');
WHEN 'Services' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Services');
WHEN 'Maintenance & Facilities' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Maintenance & Facilities');
WHEN 'IT & Technical Support' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - IT & Technical Support');
WHEN 'Quality Assurance & Compliance' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Quality Assurance & Compliance');
WHEN 'Health, Safety, and Environment' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Health, Safety, and Environment');
WHEN 'Security' THEN v_credit_account := (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_name = 'Budgetary Control - Security');

        ELSE RAISE EXCEPTION 'No Budgetary Control Account found for department: %', v_dept_name;
    END CASE;


    INSERT INTO accounting.journal_entries (journal_id, journal_date, description, total_debit, total_credit, invoice_id, currency_id)
    VALUES (v_journal_id, CURRENT_DATE, 'Budget Return Adjustment for ' || v_dept_name, NEW.returned_amount, NEW.returned_amount, NEW.budget_return_id, currency_id)
    RETURNING journal_id INTO v_journal_id;


    INSERT INTO accounting.journal_entry_lines ( journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES ( v_journal_id, 
            (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-IB8020'), 
            NEW.returned_amount, 0, 'Encumbrance Control');


    INSERT INTO accounting.journal_entry_lines ( journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES ( v_journal_id, v_credit_account, 0, NEW.returned_amount, 'Budgetary Control - ' || v_dept_name);

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_budget_return() OWNER TO postgres;

--
-- Name: create_journal_entry_for_distribution_goods_issue(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_distribution_goods_issue() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_journal_id VARCHAR(255);
    v_total_amount NUMERIC;
    v_delivery_status receipt_status_type;
    v_currency_id VARCHAR(255) := NULL; -- Default currency

BEGIN
    -- Get the delivery status from delivery_receipt
    SELECT receipt_status 
    INTO v_delivery_status
    FROM distribution.delivery_receipt dr
    JOIN distribution.billing_receipt br ON dr.delivery_receipt_id = br.delivery_receipt_id
    WHERE br.billing_receipt_id = NEW.billing_receipt_id;

    -- Only proceed if the delivery status is 'Delivered'
    IF v_delivery_status = 'Delivered' THEN

        -- Get the total amount from the sales invoice
        SELECT si.total_amount 
        INTO v_total_amount
        FROM sales.sales_invoices si
        JOIN distribution.billing_receipt br ON si.invoice_id = br.sales_invoice_id
        WHERE br.billing_receipt_id = NEW.billing_receipt_id;

        -- Insert journal entry for goods issue
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (CURRENT_DATE, 'Goods Issue Recorded', v_total_amount, v_total_amount, NEW.billing_receipt_id, v_currency_id)
        RETURNING journal_id INTO v_journal_id;

        -- Debit COGS (Cost of Goods Sold)
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount777, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CG5050'), 
                v_total_amount, 0, 'COGS for Goods Issue');

        -- Credit Inventory (reduce stock)
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CA1070'), 
                0, v_total_amount, 'Inventory Reduction for Goods Issue');

    END IF;

    RETURN NEW;
END;

$$;


ALTER FUNCTION accounting.create_journal_entry_for_distribution_goods_issue() OWNER TO postgres;

--
-- Name: create_journal_entry_for_goods_issue(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_goods_issue() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_journal_id VARCHAR(255); 
    v_transaction_cost DECIMAL(18,2);
BEGIN
    -- Check if the document type is 'Goods Issue'
    IF (SELECT document_type FROM operations.document_header WHERE document_id = NEW.document_id) = 'Goods Issue' THEN

        -- Get transaction cost from the document header
        SELECT transaction_cost INTO v_transaction_cost
        FROM operations.document_header
        WHERE document_id = NEW.document_id;

        -- Insert into journal_entries
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (CURRENT_DATE, 'Goods Issue' || NEW.document_id, v_transaction_cost, v_transaction_cost, NEW.document_id, NULL)
        RETURNING journal_id INTO v_journal_id;

        -- Debit Work-in-Process Inventory
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CA1060'), v_transaction_cost, 0, 'Work-in-Process Inventory');

        -- Credit Raw Materials Used
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CG5010'), 0, v_transaction_cost, 'Raw Materials Used');
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_goods_issue() OWNER TO postgres;

--
-- Name: create_journal_entry_for_goods_receipt(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_goods_receipt() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_journal_id VARCHAR(255); 
    v_transaction_cost DECIMAL(18,2);
BEGIN
    -- Check if the document type is 'Goods Receipt'
    IF (SELECT document_type FROM operations.document_header WHERE document_id = NEW.document_id) = 'Goods Receipt' THEN

        -- Get transaction cost from the document header
        SELECT transaction_cost INTO v_transaction_cost
        FROM operations.document_header
        WHERE document_id = NEW.document_id;

        -- Insert into journal_entries
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (CURRENT_DATE, 'Goods Receipt' || NEW.document_id, v_transaction_cost, v_transaction_cost, NEW.document_id, NULL)
        RETURNING journal_id INTO v_journal_id;

        -- Debit Work-in-Process Inventory
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CA1070'), v_transaction_cost, 0, 'Finished Goods Inventory');

        -- Credit Raw Materials Used
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CA1060'), 0, v_transaction_cost, 'Work-in-Process Inventory');
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_goods_receipt() OWNER TO postgres;

--
-- Name: create_journal_entry_for_grpo(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_grpo() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_journal_id VARCHAR(255); 
    v_transaction_cost DECIMAL(18,2);
    v_gl_account_id VARCHAR(255);
    v_account_name VARCHAR(255);
    v_vendor_code VARCHAR(255);
  
BEGIN
    -- Check if the document type is 'GRPO'
    IF (SELECT document_type FROM operations.document_header WHERE document_id = NEW.document_id) = 'GRPO' THEN

               -- Get the corresponding gl_account_id and account_name for the vendor
        SELECT gl_account_id, account_name
        INTO v_gl_account_id, v_account_name
        FROM accounting.general_ledger_accounts
        WHERE account_id = NEW.vendor_code;



        -- Get transaction cost from the document header
        SELECT transaction_cost INTO v_transaction_cost
        FROM operations.document_header
        WHERE document_id = NEW.document_id;


        -- Insert into journal_entries
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (CURRENT_DATE, 'Goods Receipt PO', v_transaction_cost, v_transaction_cost, NEW.document_id , NULL)
        RETURNING journal_id INTO v_journal_id;
        
               -- Debit Accounts Payable (Account Code: 2010) for the specific vendor
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, v_gl_account_id, v_transaction_cost, 0, v_account_name);
        
        -- Credit Cash in Bank (Account Code: 1020)
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CA1020'), 0, v_transaction_cost, 'Bank Asset');

        -- Debit Raw Materials Inventory
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CA1050'), v_transaction_cost, 0, 'Raw Materials Inventory');

        -- Credit Accounts Payable or Cash
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code =  'ACC-COA-2025-CA1020'), 0, v_transaction_cost, 'Bank Asset');

     

        
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_grpo() OWNER TO postgres;

--
-- Name: create_journal_entry_for_payroll(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_payroll() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_journal_id  VARCHAR(255);
    currency_id  VARCHAR(255) := NULL; 
    v_gl_account_id VARCHAR(255);
    v_account_name VARCHAR(255);

BEGIN
    IF NEW.payment_status = 'Paid' THEN
    -- Get the corresponding gl_account_id for the employee
    SELECT gl_account_id, account_name
    INTO v_gl_account_id, v_account_name
    FROM accounting.general_ledger_accounts
    WHERE account_id = NEW.employee_id;
    
    -- Insert into journal_entries table with payroll_id as invoice_id
    INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
    VALUES (NEW.payment_date, 'Payroll Expense', NEW.net_salary, NEW.net_salary, NEW.payroll_id, currency_id)
    RETURNING journal_id INTO v_journal_id;
    
    -- Debit Salaries & Wages (account_code: 6010) for the specific employee
    INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES (v_journal_id, v_gl_account_id, NEW.net_salary, 0, v_account_name);
    
    -- Credit Cash in Bank (account_code: 1020)
    INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CL2010' AND account_name = 'BANK - BDO'), 0, NEW.net_salary, 'Payroll Payment');

    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_payroll() OWNER TO postgres;

--
-- Name: create_journal_entry_for_purchase_invoice(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_purchase_invoice() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_journal_id VARCHAR(255);
    currency_id VARCHAR(255) := NULL; -- Default currency ID
    v_gl_account_id VARCHAR(255);
    v_vendor_code VARCHAR(255);
    v_account_name VARCHAR(255);
BEGIN
    IF NEW.status = 'Completed' THEN
	
        -- Get the vendor_code by joining purchase_order and purchase_quotation
        SELECT pq.vendor_code 
        INTO v_vendor_code
        FROM purchasing.purchase_invoice pi
        JOIN purchasing.purchase_order po ON pi.purchase_id = po.purchase_id
        JOIN purchasing.purchase_quotation pq ON po.quotation_id = pq.quotation_id
        WHERE pi.invoice_id = NEW.invoice_id;

        -- Get the corresponding gl_account_id and account_name for the vendor
        SELECT gl_account_id, account_name
        INTO v_gl_account_id, v_account_name
        FROM accounting.general_ledger_accounts
        WHERE account_id = v_vendor_code;

        -- Insert into journal_entries table with invoice_id as reference
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (NEW.document_date, 'Purchase Invoice Entry', NEW.total_credit, NEW.total_credit, NEW.invoice_id, currency_id)
        RETURNING journal_id INTO v_journal_id;
        
        -- Debit Accounts Payable (account_code: 2010) for the specific vendor
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, v_gl_account_id, NEW.total_credit, 0, v_account_name);  

        -- Credit Cash in Bank (account_code: 1020)
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code =  'ACC-COA-2025-CA1020'), 0, NEW.total_credit, 'Bank Asset');
    
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_purchase_invoice() OWNER TO postgres;

--
-- Name: create_journal_entry_for_receipt(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_receipt() RETURNS trigger
    LANGUAGE plpgsql
    AS $$



DECLARE
    v_journal_id VARCHAR(255);
    v_customer_name VARCHAR(255);
    v_gl_account_id VARCHAR(255);
    v_account_name  VARCHAR(255);
    currency_id VARCHAR(255) := NULL; -- Default currency ID
    v_total_payment NUMERIC; -- Correct payment calculation for partial payment
BEGIN
    -- Get the corresponding gl_account_id and account_name for the customer
    SELECT gl_account_id, account_name
    INTO v_gl_account_id, v_account_name
    FROM accounting.general_ledger_accounts
    WHERE account_id = NEW.customer_id;

    -- If the invoice is fully settled
    IF NEW.remaining_amount = 0 THEN
        -- Insert into journal_entries for full payment
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (NEW.or_date, 'Sales Order', NEW.settled_amount, NEW.settled_amount, NEW.invoice_id, currency_id)
        RETURNING journal_id INTO v_journal_id;

        -- Debit Cash/Bank
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, v_gl_account_id, NEW.settled_amount, 0, v_account_name);

        -- Credit Accounts Receivable
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (
            v_journal_id,  
            (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-RR4010'),
            0, NEW.settled_amount, 'Sales Revenue'
        );
    ELSE 
        -- Calculate partial payment amount
        v_total_payment := NEW.settled_amount - NEW.remaining_amount; -- This is for partial payments

        -- Insert into journal_entries for partial payment
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (NEW.ora_date, 'Sales Order - Partial Payment', v_total_payment, v_total_payment, NEW.invoice_id, currency_id)
        RETURNING journal_id INTO v_journal_id;

        -- Debit Cash/Bank
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, v_gl_account_id, v_total_payment, 0, v_account_name);

        -- Credit Partial Payment - Accounts Receivable
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (
            v_journal_id,  
            (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-CA1030' AND account_name = 'Partial Payment - Accounts Receivable'),
            0, v_total_payment,  'Partial Payment - Accounts Receivable'
        );
    END IF;

    RETURN NEW;
END;



$$;


ALTER FUNCTION accounting.create_journal_entry_for_receipt() OWNER TO postgres;

--
-- Name: create_journal_entry_for_second_payment(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_second_payment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_journal_id VARCHAR(255);
    v_customer_name VARCHAR(255);
    v_gl_account_id VARCHAR(255);
    v_account_name  VARCHAR(255);
    currency_id VARCHAR(255) := NULL; -- Default currency ID
    v_total_payment NUMERIC;
BEGIN
    -- Check if the remaining_amount has become zero after the second payment
    IF NEW.remaining_amount = 0 AND OLD.remaining_amount > 0 THEN
        -- Get the corresponding gl_account_id and account_name for the customer
        SELECT gl_account_id, account_name
        INTO v_gl_account_id, v_account_name
        FROM accounting.general_ledger_accounts
        WHERE account_id = NEW.customer_id;

        -- Calculate the second payment amount (difference between remaining and settled amount)
        v_total_payment := OLD.remaining_amount;

        -- Insert into journal_entries for the second payment (full payment now)
        INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
        VALUES (NEW.or_date, 'Sales Order - Full Payment (Second Payment)', v_total_payment, v_total_payment, NEW.invoice_id, currency_id)
        RETURNING journal_id INTO v_journal_id;

        -- Debit Cash/Bank
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (v_journal_id, v_gl_account_id, v_total_payment, 0, v_account_name);

        -- Credit Accounts Receivable (Sales Revenue)
        INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
        VALUES (
            v_journal_id,  
            (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-RR4010'),
            0, v_total_payment, 'Sales Revenue'
        );
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_second_payment() OWNER TO postgres;

--
-- Name: create_journal_entry_for_service_billing(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_service_billing() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_journal_id VARCHAR(255);
    v_entry_line_id VARCHAR(255);
    currency_id VARCHAR(255) := NULL;  -- Default currency
BEGIN

    -- Check if the billing status is 'Paid'
    IF NEW.billing_status = 'Paid' THEN
    -- Insert journal entry
    INSERT INTO accounting.journal_entries (journal_id, journal_date, description, total_debit, total_credit, invoice_id, currency_id)
    VALUES (v_journal_id, CURRENT_DATE, 'Service Billing ', NEW.total_payable, NEW.total_payable, NEW.service_billing_id, currency_id)
    RETURNING journal_id INTO v_journal_id;

    
    -- Debit: Accounts Receivable if Unpaid, Cash in Bank if Paid
    INSERT INTO accounting.journal_entry_lines ( journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES (
      
        v_journal_id, 
        (SELECT gl_account_id FROM accounting.general_ledger_accounts
         WHERE account_code = 'ACC-COA-2025-CA1020' ), NEW.total_payable, 0, 'Service Payment' );


    -- Credit: Service Revenue Account
    INSERT INTO accounting.journal_entry_lines ( journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES (
        v_journal_id, 
        (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code = 'ACC-COA-2025-RR4020' LIMIT 1), 
        0, NEW.service_billing_amount, 'Service Revenue'
    );

         END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.create_journal_entry_for_service_billing() OWNER TO postgres;

--
-- Name: create_journal_entry_for_shipping_cost(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.create_journal_entry_for_shipping_cost() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_journal_id VARCHAR(255);
    currency_id VARCHAR(255) := NULL; 
    v_total_shipping_cost NUMERIC;
    	v_gl_account_id VARCHAR(255);
	v_account_name VARCHAR(255);
BEGIN

    IF NEW.shipment_status = 'Delivered' THEN

    SELECT sc.total_shipping_cost
    INTO v_total_shipping_cost
    FROM distribution.shipment_details sd
    JOIN  distribution.shipping_cost sc ON sd.shipping_cost_id = sc.shipping_cost_id
    WHERE sd.shipment_id = NEW.shipment_id;

     -- Get the corresponding gl_account_id for the carrier
    SELECT gl_account_id, account_name
    INTO v_gl_account_id, v_account_name
    FROM accounting.general_ledger_accounts
    WHERE account_id = NEW.carrier_id;
    
    -- Insert journal entry for shipping cost
    INSERT INTO accounting.journal_entries (journal_date, description, total_debit, total_credit, invoice_id, currency_id)
    VALUES (CURRENT_DATE, 'Shipping Cost Recorded', v_total_shipping_cost, v_total_shipping_cost, NEW.shipment_id, currency_id)
    RETURNING journal_id INTO v_journal_id;

    -- Debit Freight/Shipping Expense (6050)
    INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES (v_journal_id, v_gl_account_id, v_total_shipping_cost, 0, v_account_name);

    -- Credit Accounts Payable (2000)
    INSERT INTO accounting.journal_entry_lines (journal_id, gl_account_id, debit_amount, credit_amount, description)
    VALUES (v_journal_id,  (SELECT gl_account_id FROM accounting.general_ledger_accounts WHERE account_code =  'ACC-COA-2025-CA1020'), 
            0, v_total_shipping_cost, 'Shipping Cost');
    END IF;
    RETURN NEW;
END;

$$;


ALTER FUNCTION accounting.create_journal_entry_for_shipping_cost() OWNER TO postgres;

--
-- Name: generate_entry_line_id(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.generate_entry_line_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'JEL'; 
    module_name TEXT := 'ACC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.entry_line_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.generate_entry_line_id() OWNER TO postgres;

--
-- Name: generate_gl_account_id(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.generate_gl_account_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'GLA'; 
    module_name TEXT := 'ACC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.gl_account_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.generate_gl_account_id() OWNER TO postgres;

--
-- Name: generate_journal_id(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.generate_journal_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'JOE'; 
    module_name TEXT := 'ACC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.journal_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.generate_journal_id() OWNER TO postgres;

--
-- Name: generate_or_id(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.generate_or_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'OFR'; 
    module_name TEXT := 'ACC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.or_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.generate_or_id() OWNER TO postgres;

--
-- Name: generate_report_id(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.generate_report_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'REP';  -- Prefix for report IDs
    module_name TEXT := 'ACC';    -- Module name
BEGIN
    -- Generate a unique code using MD5 and a random number
    unique_code := substr(md5(random()::text), 1, 6);
    -- Concatenate the module name, prefix, current year, and unique code
    NEW.report_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.generate_report_id() OWNER TO postgres;

--
-- Name: sync_carrier_to_gl_accounts(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.sync_carrier_to_gl_accounts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_account_name VARCHAR(255);
    v_account_code VARCHAR(255) := 'ACC-COA-2025-SD6120';  -- Fixed account code for carrier (Accounts Payable)
BEGIN
    -- Generate the account name dynamically
    v_account_name := 'Courier - ' || NEW.carrier_name;

    -- Insert into general ledger accounts
    INSERT INTO accounting.general_ledger_accounts (gl_account_id, account_name, account_code, account_id, status, created_at)
    VALUES (NEW.carrier_id, v_account_name, v_account_code, NEW.carrier_id, 'Active', CURRENT_TIMESTAMP);

    RETURN NEW;
END;

$$;


ALTER FUNCTION accounting.sync_carrier_to_gl_accounts() OWNER TO postgres;

--
-- Name: sync_customer_to_gl_accounts(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.sync_customer_to_gl_accounts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_account_name VARCHAR(255);
    v_account_code VARCHAR(255) := 'ACC-COA-2025-CA1030';  -- Fixed account code for customers
BEGIN
    -- Generate the account name dynamically
    v_account_name := 'Customer - ' || NEW.name;

    -- Insert into general ledger accounts
    INSERT INTO accounting.general_ledger_accounts (gl_account_id, account_name, account_code, account_id, status, created_at)
    VALUES (NEW.gl_account_id, v_account_name, v_account_code, NEW.customer_id, NEW.status, CURRENT_TIMESTAMP);

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.sync_customer_to_gl_accounts() OWNER TO postgres;

--
-- Name: sync_employee_to_gl_accounts(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.sync_employee_to_gl_accounts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    v_account_name VARCHAR(255);
    v_account_code VARCHAR(255) := ACC-COA-2025-AE6010;  -- Fixed account code for employee payroll
BEGIN
    -- Generate the account name dynamically
    v_account_name := 'Employee - ' || NEW.first_name || ' ' || NEW.last_name;

    -- Insert into general ledger accounts
    INSERT INTO accounting.general_ledger_accounts (gl_account_id, account_name, account_code, account_id, status, created_at)
    VALUES (NEW.employee_id, v_account_name, v_account_code, NEW.employee_id, NEW.status::status_enum, CURRENT_TIMESTAMP);

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.sync_employee_to_gl_accounts() OWNER TO postgres;

--
-- Name: sync_vendor_to_gl_accounts(); Type: FUNCTION; Schema: accounting; Owner: postgres
--

CREATE FUNCTION accounting.sync_vendor_to_gl_accounts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_account_name VARCHAR(255);
    v_account_code VARCHAR(255) := 'ACC-COA-2025-CL2010';  -- Fixed account code for vendors (Accounts Payable)
BEGIN
    -- Generate the account name dynamically
    v_account_name := 'Vendor - ' || NEW.vendor_name;

    -- Insert into general ledger accounts
    INSERT INTO accounting.general_ledger_accounts (gl_account_id, account_name, account_code, account_id, status, created_at)
    VALUES (NEW.vendor_code, v_account_name, v_account_code, NEW.vendor_code, NEW.status::text::status_enum, CURRENT_TIMESTAMP);

    RETURN NEW;
END;
$$;


ALTER FUNCTION accounting.sync_vendor_to_gl_accounts() OWNER TO postgres;

--
-- Name: auto_set_policy_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.auto_set_policy_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    default_policy_id VARCHAR(255);
BEGIN
    SELECT policy_id INTO default_policy_id
    FROM admin.policies
    WHERE policy_name = 'Warranty Policy'; 

    IF NEW.policy_id IS NULL THEN
        NEW.policy_id := default_policy_id;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.auto_set_policy_id() OWNER TO postgres;

--
-- Name: before_insert_users(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.before_insert_users() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.password := crypt(NEW.password, gen_salt('bf'));
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.before_insert_users() OWNER TO postgres;

--
-- Name: generate_asset_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_asset_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ASSET'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.asset_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_asset_id() OWNER TO postgres;

--
-- Name: generate_currency_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_currency_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CUR'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.currency_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_currency_id() OWNER TO postgres;

--
-- Name: generate_item_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_item_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ITEM'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.item_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_item_id() OWNER TO postgres;

--
-- Name: generate_log_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_log_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'LOG'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.log_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_log_id() OWNER TO postgres;

--
-- Name: generate_material_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_material_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'MATERIAL'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.material_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_material_id() OWNER TO postgres;

--
-- Name: generate_partner_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_partner_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PARTNER'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.partner_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_partner_id() OWNER TO postgres;

--
-- Name: generate_policy_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_policy_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'POLICY'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.policy_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_policy_id() OWNER TO postgres;

--
-- Name: generate_product_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_product_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PROD'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.product_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_product_id() OWNER TO postgres;

--
-- Name: generate_role_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_role_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ROLE'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.role_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_role_id() OWNER TO postgres;

--
-- Name: generate_user_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_user_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'USER'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.user_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_user_id() OWNER TO postgres;

--
-- Name: generate_vendor_code(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_vendor_code() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'VENDOR'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.vendor_code := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_vendor_code() OWNER TO postgres;

--
-- Name: generate_warehouse_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generate_warehouse_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'WARE'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.warehouse_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.generate_warehouse_id() OWNER TO postgres;

--
-- Name: generic_audit_trigger(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.generic_audit_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    action_type TEXT;
BEGIN
    IF TG_OP = 'INSERT' THEN
        action_type := 'INSERT';
    ELSIF TG_OP = 'UPDATE' THEN
        action_type := 'UPDATE';
    ELSIF TG_OP = 'DELETE' THEN
        action_type := 'DELETE';
    ELSE
        action_type := 'UNKNOWN';
    END IF;

    INSERT INTO admin.audit_log (
        user_id,
        action,
        timestamp,
        ip_address
    ) VALUES (
        NULL,
        action_type || ' on table ' || TG_TABLE_NAME,
        NOW(),
        inet_client_addr()
    );

    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$;


ALTER FUNCTION admin.generic_audit_trigger() OWNER TO postgres;

--
-- Name: hash_user_passwords(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.hash_user_passwords() RETURNS void
    LANGUAGE plpgsql
    AS $_$
BEGIN
    UPDATE admin.users
    SET password = crypt(password, gen_salt('bf'))
    WHERE password NOT LIKE '$2a$%';
END;
$_$;


ALTER FUNCTION admin.hash_user_passwords() OWNER TO postgres;

--
-- Name: notifications_id(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.notifications_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'NTF'; 
    module_name TEXT := 'ADMIN';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.notifications_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.notifications_id() OWNER TO postgres;

--
-- Name: sync_bpm_vendor(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.sync_bpm_vendor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO admin.business_partner_master (vendor_code, partner_name, category, contact_info)
    VALUES (NEW.vendor_code, NEW.vendor_name, 'Vendor', NEW.contact_person)
    ON CONFLICT (vendor_code) DO UPDATE
    SET
        partner_name = EXCLUDED.partner_name,
        contact_info = EXCLUDED.contact_info;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.sync_bpm_vendor() OWNER TO postgres;

--
-- Name: sync_item_master_data(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.sync_item_master_data() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insert into item_master_data based on the source table
    IF TG_TABLE_NAME = 'assets' THEN
        INSERT INTO admin.item_master_data (asset_id, item_type, item_name, manage_item_by)
        VALUES (NEW.asset_id, 'Asset', NEW.asset_name, 'Serial Number');

    ELSIF TG_TABLE_NAME = 'products' THEN
        INSERT INTO admin.item_master_data (product_id, item_type, item_name, unit_of_measure, manage_item_by, item_status)
        VALUES (NEW.product_id, 'Product', NEW.product_name, NEW.unit_of_measure, 'Batches', NEW.item_status);

    ELSIF TG_TABLE_NAME = 'raw_materials' THEN
        INSERT INTO admin.item_master_data (material_id, item_type, item_name, unit_of_measure, manage_item_by, preferred_vendor, purchasing_uom)
        VALUES (NEW.material_id, 'Raw Material', NEW.material_name, NEW.unit_of_measure, 'None', NEW.vendor_code, NEW.unit_of_measure);
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.sync_item_master_data() OWNER TO postgres;

--
-- Name: sync_users_from_employees(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.sync_users_from_employees() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_year TEXT;
    generated_email TEXT;
    generated_password TEXT;
BEGIN
    current_year := EXTRACT(YEAR FROM NOW())::TEXT;

    generated_email := LOWER(REPLACE(NEW.first_name, ' ', '') || '.' || REPLACE(NEW.last_name, ' ', '') || '@kinetiq.ph');

    generated_password := LOWER(NEW.first_name || REPLACE(NEW.last_name, ' ', '') || TO_CHAR(CURRENT_DATE, 'YYYY'));

    INSERT INTO admin.users (
        user_id,
        employee_id,
        first_name,
        last_name,
        email,
        password,
        role_id,
        status,
        type,
        created_at,
        updated_at
    ) VALUES (
        NULL,
        NEW.employee_id,
        NEW.first_name,
        NEW.last_name,
        generated_email,
        generated_password,
        NULL,
        'Active',
        'Employee',
        NOW(),
        NOW()
    )
    ON CONFLICT (employee_id) DO UPDATE 
    SET 
        first_name = EXCLUDED.first_name,
        last_name = EXCLUDED.last_name,
        email = EXCLUDED.email,
        password = EXCLUDED.password, 
        updated_at = NOW();

    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.sync_users_from_employees() OWNER TO postgres;

--
-- Name: track_user_activity(); Type: FUNCTION; Schema: admin; Owner: postgres
--

CREATE FUNCTION admin.track_user_activity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.user_id IS NULL THEN
        NEW.user_id := (SELECT current_setting('app.current_user', true));
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION admin.track_user_activity() OWNER TO postgres;

--
-- Name: generate_approval_request_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_approval_request_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'LOR'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.approval_request_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_approval_request_id() OWNER TO postgres;

--
-- Name: generate_billing_receipt_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_billing_receipt_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BR'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.billing_receipt_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_billing_receipt_id() OWNER TO postgres;

--
-- Name: generate_carrier_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_carrier_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CAR'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.carrier_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_carrier_id() OWNER TO postgres;

--
-- Name: generate_del_order_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_del_order_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'DO'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.del_order_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_del_order_id() OWNER TO postgres;

--
-- Name: generate_delivery_receipt_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_delivery_receipt_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'DR'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.delivery_receipt_id:= module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_delivery_receipt_id() OWNER TO postgres;

--
-- Name: generate_failed_shipment_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_failed_shipment_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'FS'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.failed_shipment_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_failed_shipment_id() OWNER TO postgres;

--
-- Name: generate_goods_issue_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_goods_issue_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'GI'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.goods_issue_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_goods_issue_id() OWNER TO postgres;

--
-- Name: generate_operational_cost_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_operational_cost_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'OS'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.operational_cost_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_operational_cost_id() OWNER TO postgres;

--
-- Name: generate_packing_cost_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_packing_cost_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PC'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.packing_cost_id  := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_packing_cost_id() OWNER TO postgres;

--
-- Name: generate_packing_list_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_packing_list_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PC'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.packing_list_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_packing_list_id() OWNER TO postgres;

--
-- Name: generate_picking_list_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_picking_list_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PIL'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.picking_list_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_picking_list_id() OWNER TO postgres;

--
-- Name: generate_rejection_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_rejection_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'REJ'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.rejection_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_rejection_id() OWNER TO postgres;

--
-- Name: generate_rework_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_rework_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'RO'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.rework_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_rework_id() OWNER TO postgres;

--
-- Name: generate_shipment_details_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_shipment_details_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SD'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.shipment_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_shipment_details_id() OWNER TO postgres;

--
-- Name: generate_shipping_cost_id(); Type: FUNCTION; Schema: distribution; Owner: postgres
--

CREATE FUNCTION distribution.generate_shipping_cost_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SC'; 
    module_name TEXT := 'DIS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.shipping_cost_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION distribution.generate_shipping_cost_id() OWNER TO postgres;

--
-- Name: generate_budget_allocation_id(); Type: FUNCTION; Schema: finance; Owner: postgres
--

CREATE FUNCTION finance.generate_budget_allocation_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BAA'; 
    module_name TEXT := 'FNC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.budget_allocation_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION finance.generate_budget_allocation_id() OWNER TO postgres;

--
-- Name: generate_budget_approvals_id(); Type: FUNCTION; Schema: finance; Owner: postgres
--

CREATE FUNCTION finance.generate_budget_approvals_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BUA'; 
    module_name TEXT := 'FNC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.budget_approvals_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION finance.generate_budget_approvals_id() OWNER TO postgres;

--
-- Name: generate_budget_request_id(); Type: FUNCTION; Schema: finance; Owner: postgres
--

CREATE FUNCTION finance.generate_budget_request_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BRQ';
    module_name TEXT := 'FNC';
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.budget_request_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION finance.generate_budget_request_id() OWNER TO postgres;

--
-- Name: generate_budget_return_id(); Type: FUNCTION; Schema: finance; Owner: postgres
--

CREATE FUNCTION finance.generate_budget_return_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BRT';
    module_name TEXT := 'FNC';
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.budget_return_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION finance.generate_budget_return_id() OWNER TO postgres;

--
-- Name: generate_budget_submission_id(); Type: FUNCTION; Schema: finance; Owner: postgres
--

CREATE FUNCTION finance.generate_budget_submission_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BUS'; 
    module_name TEXT := 'FNC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.budget_submission_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION finance.generate_budget_submission_id() OWNER TO postgres;

--
-- Name: generate_validation_id(); Type: FUNCTION; Schema: finance; Owner: postgres
--

CREATE FUNCTION finance.generate_validation_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BVA'; 
    module_name TEXT := 'FNC';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.validation_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION finance.generate_validation_id() OWNER TO postgres;

--
-- Name: calculate_performance_bonus(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.calculate_performance_bonus() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.performance_id := 'HR-PERF-' || to_char(CURRENT_DATE, 'YYYY') || '-' || substr(md5(random()::text), 1, 6);

    SELECT 
        CASE 
            WHEN es.base_salary IS NOT NULL THEN 
                (es.base_salary * 12 * 
                    CASE 
                        WHEN NEW.rating = 5 THEN 0.10  
                        WHEN NEW.rating = 4 THEN 0.075   
                        WHEN NEW.rating = 3 THEN 0.05   
                        WHEN NEW.rating = 2 THEN 0.025   
                        ELSE 0.00
                    END)
            WHEN es.daily_rate IS NOT NULL THEN
                (es.daily_rate * 260 * 
                    CASE 
                        WHEN NEW.rating = 5 THEN 0.10  
                        WHEN NEW.rating = 4 THEN 0.075   
                        WHEN NEW.rating = 3 THEN 0.05   
                        WHEN NEW.rating = 2 THEN 0.025   
                        ELSE 0.00
                    END)
            ELSE 0
        END 
    INTO NEW.bonus_amount
    FROM human_resources.employee_salary es
    WHERE es.employee_id = NEW.employee_id
    ORDER BY es.effective_date DESC
    LIMIT 1;

    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.calculate_performance_bonus() OWNER TO postgres;

--
-- Name: calculate_sss_contribution(character varying, numeric); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.calculate_sss_contribution(p_employee_id character varying, p_base_amount numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_employment_type VARCHAR(20);
    v_monthly_salary DECIMAL(12,2);
    v_sss_contribution DECIMAL(12,2);
BEGIN
    -- Get employment type
    SELECT employment_type INTO v_employment_type
    FROM human_resources.employees
    WHERE employee_id = p_employee_id;
    
    -- Convert daily rate to monthly equivalent if contractual/seasonal
    IF v_employment_type IN ('Contractual', 'Seasonal') THEN
        v_monthly_salary := p_base_amount * 22;  -- 22 working days/month
    ELSE
        v_monthly_salary := p_base_amount;
    END IF;
    
    v_sss_contribution := CASE
        WHEN v_monthly_salary < 3250 THEN 135.00
        WHEN v_monthly_salary BETWEEN 3250 AND 3750 THEN 157.50
        WHEN v_monthly_salary BETWEEN 3750 AND 4250 THEN 180.00
        WHEN v_monthly_salary BETWEEN 4250 AND 4750 THEN 202.50
        WHEN v_monthly_salary BETWEEN 4750 AND 5250 THEN 225.00
        WHEN v_monthly_salary BETWEEN 5250 AND 5750 THEN 247.50
        WHEN v_monthly_salary BETWEEN 5750 AND 6250 THEN 270.00
        WHEN v_monthly_salary BETWEEN 6250 AND 6750 THEN 292.50
        WHEN v_monthly_salary BETWEEN 6750 AND 7250 THEN 315.00
        WHEN v_monthly_salary BETWEEN 7250 AND 7750 THEN 337.50
        WHEN v_monthly_salary BETWEEN 7750 AND 8250 THEN 360.00
        WHEN v_monthly_salary BETWEEN 8250 AND 8750 THEN 382.50
        WHEN v_monthly_salary BETWEEN 8750 AND 9250 THEN 405.00
        WHEN v_monthly_salary BETWEEN 9250 AND 9750 THEN 427.50
        WHEN v_monthly_salary BETWEEN 9750 AND 10250 THEN 450.00
        WHEN v_monthly_salary BETWEEN 10250 AND 10750 THEN 472.50
        WHEN v_monthly_salary BETWEEN 10750 AND 11250 THEN 495.00
        WHEN v_monthly_salary BETWEEN 11250 AND 11750 THEN 517.50
        WHEN v_monthly_salary BETWEEN 11750 AND 12250 THEN 540.00
        WHEN v_monthly_salary BETWEEN 12250 AND 12750 THEN 562.50
        WHEN v_monthly_salary BETWEEN 12750 AND 13250 THEN 585.00
        WHEN v_monthly_salary BETWEEN 13250 AND 13750 THEN 607.50
        WHEN v_monthly_salary BETWEEN 13750 AND 14250 THEN 630.00
        WHEN v_monthly_salary BETWEEN 14250 AND 14750 THEN 652.50
        WHEN v_monthly_salary BETWEEN 14750 AND 15250 THEN 675.00
        WHEN v_monthly_salary BETWEEN 15250 AND 15750 THEN 697.50
        WHEN v_monthly_salary BETWEEN 15750 AND 16250 THEN 720.00
        WHEN v_monthly_salary BETWEEN 16250 AND 16750 THEN 742.50
        WHEN v_monthly_salary BETWEEN 16750 AND 17250 THEN 765.00
        WHEN v_monthly_salary BETWEEN 17250 AND 17750 THEN 787.50
        WHEN v_monthly_salary BETWEEN 17750 AND 18250 THEN 810.00
        WHEN v_monthly_salary BETWEEN 18250 AND 18750 THEN 832.50
        WHEN v_monthly_salary BETWEEN 18750 AND 19250 THEN 855.00
        WHEN v_monthly_salary BETWEEN 19250 AND 19750 THEN 877.50
        WHEN v_monthly_salary BETWEEN 19750 AND 20250 THEN 900.00
        WHEN v_monthly_salary BETWEEN 20250 AND 20750 THEN 922.50
        WHEN v_monthly_salary BETWEEN 20750 AND 21250 THEN 945.00
        WHEN v_monthly_salary BETWEEN 21250 AND 21750 THEN 967.50
        WHEN v_monthly_salary BETWEEN 21750 AND 22250 THEN 990.00
        WHEN v_monthly_salary BETWEEN 22250 AND 22750 THEN 1012.50
        WHEN v_monthly_salary BETWEEN 22750 AND 23250 THEN 1035.00
        WHEN v_monthly_salary BETWEEN 23250 AND 23750 THEN 1057.50
        WHEN v_monthly_salary BETWEEN 23750 AND 24250 THEN 1080.00
        WHEN v_monthly_salary BETWEEN 24250 AND 24750 THEN 1102.50
        WHEN v_monthly_salary >= 24750 THEN 1125.00
        ELSE 0.00
    END;
    
    RETURN v_sss_contribution;
END;
$$;


ALTER FUNCTION human_resources.calculate_sss_contribution(p_employee_id character varying, p_base_amount numeric) OWNER TO postgres;

--
-- Name: calculate_tax(numeric); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.calculate_tax(gross_pay numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$
BEGIN	
 RETURN CASE
        WHEN gross_pay <= 20833 THEN 0
        WHEN gross_pay <= 33333 THEN (gross_pay - 20833) * 0.20
        WHEN gross_pay <= 66667 THEN 2500 + (gross_pay - 33333) * 0.25
        WHEN gross_pay <= 166667 THEN 10833 + (gross_pay - 66667) * 0.30
        WHEN gross_pay <= 666667 THEN 40833.33 + (gross_pay - 166667) * 0.32
        ELSE 200833.33 + (gross_pay - 666667) * 0.35
    END;
END;
$$;


ALTER FUNCTION human_resources.calculate_tax(gross_pay numeric) OWNER TO postgres;

--
-- Name: calculate_work_hours(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.calculate_work_hours() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 NEW.work_hours := 
        CASE WHEN NEW.time_out IS NULL THEN NULL
        ELSE EXTRACT(EPOCH FROM (NEW.time_out - NEW.time_in))/3600 END;
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.calculate_work_hours() OWNER TO postgres;

--
-- Name: deduct_leave_balances(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.deduct_leave_balances() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Only deduct when status changes to fully approved
    IF NEW.status = 'Approved by Management' AND OLD.status != 'Approved by Management' THEN
        UPDATE human_resources.employee_leave_balances
        SET
            sick_leave_remaining = CASE 
                WHEN NEW.leave_type = 'Sick' THEN sick_leave_remaining - NEW.total_days 
                ELSE sick_leave_remaining END,
            vacation_leave_remaining = CASE 
                WHEN NEW.leave_type = 'Vacation' THEN vacation_leave_remaining - NEW.total_days 
                ELSE vacation_leave_remaining END,
			maternity_leave_remaining = CASE 
                WHEN NEW.leave_type = 'Maternity' THEN maternity_leave_remaining - NEW.total_days 
                ELSE maternity_leave_remaining END,
            paternity_leave_remaining = CASE 
                WHEN NEW.leave_type = 'Paternity' THEN paternity_leave_remaining - NEW.total_days 
                ELSE paternity_leave_remaining END,
            solo_parent_leave_remaining = CASE 
                WHEN NEW.leave_type = 'Solo Parent' THEN solo_parent_leave_remaining - NEW.total_days 
                ELSE solo_parent_leave_remaining END,
            unpaid_leave_taken = CASE 
                WHEN NEW.leave_type = 'Unpaid' THEN unpaid_leave_taken + NEW.total_days 
                ELSE unpaid_leave_taken END,
            updated_at = CURRENT_TIMESTAMP
        WHERE employee_id = NEW.employee_id
        AND year = EXTRACT(YEAR FROM NEW.start_date);
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.deduct_leave_balances() OWNER TO postgres;

--
-- Name: detect_attendance_status(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.detect_attendance_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.time_in IS NULL THEN
        NEW.status := 'Absent';
    ELSIF NEW.time_in > '[expected_start_time]' THEN 
        NEW.status := 'Late';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.detect_attendance_status() OWNER TO postgres;

--
-- Name: generate_allocation_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_allocation_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
 NEW.allocation_id := 'ALLOC-' || to_char(CURRENT_DATE, 'YYYYMM') || '-' || 
                        lpad(floor(random() * 10000)::text, 4, '0');
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_allocation_id() OWNER TO postgres;

--
-- Name: generate_attendance_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_attendance_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 unique_code TEXT;
    module_prefix TEXT := 'ATT'; 
    module_name TEXT := 'HR';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.attendance_id := module_name || '-' || module_prefix || '-' || 
                        to_char(CURRENT_DATE, 'YYYYMMDD') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_attendance_id() OWNER TO postgres;

--
-- Name: generate_bi_monthly_payroll(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_bi_monthly_payroll() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_emp_data RECORD;
    v_attendance RECORD;
    v_calendar_data RECORD;
    v_performance_bonus DECIMAL(12,2) := 0;
    v_monthly_salary_equivalent DECIMAL(12,2);
    v_actual_work_days INT;
    v_daily_rate DECIMAL(12,2);
    v_base_pay DECIMAL(12,2);
    v_holiday_pay_calc DECIMAL(12,2) := 0;
    v_overtime_pay_calc DECIMAL(12,2) := 0;
    v_pay_period_days INT;
    v_expected_work_days INT;
    v_actual_attendance_days INT;
BEGIN
    -- 1. DATA VALIDATION
    IF NEW.employee_id IS NULL THEN
        RAISE EXCEPTION 'Employee ID cannot be null for payroll generation';
    END IF;

    IF NEW.pay_period_start IS NULL OR NEW.pay_period_end IS NULL THEN
        RAISE EXCEPTION 'Pay period dates must be specified';
    END IF;

    IF NEW.pay_period_end <= NEW.pay_period_start THEN
        RAISE EXCEPTION 'Pay period end date must be after start date';
    END IF;

    -- Get employee data with salary info
    SELECT 
        e.employment_type,
        es.base_salary,
        es.daily_rate,
        CASE 
            WHEN es.base_salary IS NOT NULL THEN es.base_salary / 2 
            ELSE es.daily_rate * 15 
        END AS semi_monthly_rate,
        CASE 
            WHEN es.base_salary IS NOT NULL THEN es.base_salary / (22 * 8) 
            ELSE es.daily_rate / 8 
        END AS hourly_rate,
        CASE 
            WHEN es.base_salary IS NOT NULL THEN es.base_salary 
            ELSE es.daily_rate * 22 
        END AS monthly_equivalent
    INTO v_emp_data
    FROM human_resources.employees e
    JOIN human_resources.employee_salary es ON e.employee_id = es.employee_id
    WHERE e.employee_id = NEW.employee_id
    ORDER BY es.effective_date DESC 
    LIMIT 1;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No salary record found for employee %', NEW.employee_id;
    END IF;

    -- Calculate total days in pay period
    v_pay_period_days := NEW.pay_period_end - NEW.pay_period_start + 1;

    -- Get calendar data
    SELECT 
        COUNT(*) FILTER (WHERE is_holiday = TRUE AND is_special = FALSE) AS holidays,
        COUNT(*) FILTER (WHERE is_workday = TRUE) AS work_days,
        COUNT(*) AS total_days
    INTO v_calendar_data
    FROM human_resources.calendar_dates
    WHERE date BETWEEN NEW.pay_period_start AND NEW.pay_period_end;

    IF v_calendar_data.total_days < v_pay_period_days THEN
        RAISE EXCEPTION 'Missing calendar data for some days in pay period % to %', 
                        NEW.pay_period_start, NEW.pay_period_end;
    END IF;

    -- Get attendance data
    SELECT 
        COUNT(*) FILTER (WHERE status = 'Absent') AS absent_days,
        SUM(late_hours) AS total_late_hours,
        SUM(undertime_hours) AS total_undertime_hours,
        COUNT(*) FILTER (WHERE is_holiday = TRUE AND time_in IS NOT NULL) AS worked_holidays,
        SUM(CASE 
            WHEN status = 'Present' OR status = 'Late' THEN 
                CASE 
                    WHEN is_holiday THEN 1.3 
                    ELSE 1.0 
                END
            ELSE 0 
        END) AS effective_work_days,
        COUNT(*) AS recorded_days
    INTO v_attendance
    FROM human_resources.attendance_tracking
    WHERE employee_id = NEW.employee_id 
    AND date BETWEEN NEW.pay_period_start AND NEW.pay_period_end;

    IF v_attendance.recorded_days < v_calendar_data.work_days THEN
        RAISE WARNING 'Incomplete attendance records for employee % - only % of % work days recorded', 
                      NEW.employee_id, v_attendance.recorded_days, v_calendar_data.work_days;
    END IF;

    -- Compute base pay
    IF v_emp_data.employment_type = 'Regular' THEN
        v_base_pay := v_emp_data.semi_monthly_rate;
    ELSE
        v_actual_work_days := COALESCE(v_attendance.effective_work_days, 0);
        v_base_pay := v_emp_data.daily_rate * v_actual_work_days;
    END IF;

    -- Compute overtime
    v_overtime_pay_calc := NEW.overtime_hours * v_emp_data.hourly_rate * 1.5;

    -- Compute holiday pay
    IF v_emp_data.employment_type = 'Regular' THEN
        v_holiday_pay_calc := v_calendar_data.holidays * (v_emp_data.base_salary / 22);
        IF COALESCE(v_attendance.worked_holidays, 0) > 0 THEN
            v_holiday_pay_calc := v_holiday_pay_calc + 
                                  (v_attendance.worked_holidays * (v_emp_data.base_salary / 22) * 0.3);
        END IF;
    ELSE
        v_holiday_pay_calc := COALESCE(v_attendance.worked_holidays, 0) * v_emp_data.daily_rate * 1.3;
    END IF;

    -- Bonus pay for December
    IF EXTRACT(MONTH FROM NEW.pay_period_end) = 12 THEN
        SELECT bonus_amount INTO v_performance_bonus
        FROM human_resources.employee_performance
        WHERE employee_id = NEW.employee_id
        AND EXTRACT(YEAR FROM review_date) = EXTRACT(YEAR FROM NEW.pay_period_end)
        ORDER BY review_date DESC 
        LIMIT 1;
    END IF;

    -- Assign values
    NEW.base_salary := v_base_pay;
    NEW.overtime_pay := v_overtime_pay_calc;
    NEW.holiday_pay := v_holiday_pay_calc;
    NEW.bonus_pay := COALESCE(v_performance_bonus, 0);

    IF v_emp_data.employment_type = 'Regular' AND EXTRACT(MONTH FROM NEW.pay_period_end) = 12 THEN
        NEW.thirteenth_month_pay := v_emp_data.semi_monthly_rate;
    ELSE
        NEW.thirteenth_month_pay := 0;
    END IF;

    -- Contributions
    v_monthly_salary_equivalent := v_emp_data.monthly_equivalent;

    NEW.sss_contribution := human_resources.calculate_sss_contribution(NEW.employee_id, v_monthly_salary_equivalent);
    NEW.philhealth_contribution := LEAST(v_monthly_salary_equivalent * 0.02, 1800.00);
    NEW.pagibig_contribution := CASE 
        WHEN v_monthly_salary_equivalent <= 1500 THEN v_monthly_salary_equivalent * 0.01 
        ELSE LEAST(v_monthly_salary_equivalent * 0.02, 100.00) 
    END;

    -- Deductions
    NEW.late_deduction := COALESCE(v_attendance.total_late_hours, 0) * v_emp_data.hourly_rate;
    NEW.absent_deduction := COALESCE(v_attendance.absent_days, 0) * 
        CASE 
            WHEN v_emp_data.employment_type = 'Regular' THEN v_emp_data.base_salary / 22 
            ELSE v_emp_data.daily_rate 
        END;
    NEW.undertime_deduction := COALESCE(v_attendance.total_undertime_hours, 0) * v_emp_data.hourly_rate;

    -- Tax
    NEW.tax := human_resources.calculate_tax(
        NEW.base_salary + 
        NEW.overtime_pay + 
        NEW.holiday_pay + 
        NEW.bonus_pay + 
        NEW.thirteenth_month_pay
    );

    RETURN NEW;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;


ALTER FUNCTION human_resources.generate_bi_monthly_payroll() OWNER TO postgres;

--
-- Name: generate_department_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_department_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'DEPT'; 
    module_name TEXT := 'HR';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.dept_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_department_id() OWNER TO postgres;

--
-- Name: generate_employee_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_employee_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 unique_code TEXT;
    module_prefix TEXT := 'EMP'; 
    module_name TEXT := 'HR';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.employee_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_employee_id() OWNER TO postgres;

--
-- Name: generate_final_payroll(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_final_payroll() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_base_salary DECIMAL(12,2);
    v_final_payroll_id VARCHAR(255);
    v_employment_type VARCHAR(50);
BEGIN
    -- Generate payroll ID
    v_final_payroll_id := 'FPAY-' || NEW.employee_id || '-' || to_char(NEW.last_working_date, 'YYYYMMDD');

    -- Get current salary data
    SELECT 
        es.base_salary,
        es.employment_type
    INTO 
        v_base_salary,
        v_employment_type
    FROM human_resources.employee_salary es
    WHERE es.employee_id = NEW.employee_id
    ORDER BY es.effective_date DESC
    LIMIT 1;

    -- Insert final payroll record
    INSERT INTO human_resources.payroll (
        payroll_id,
        employee_id,
        pay_period_start,
        pay_period_end,
        employment_type,
        base_salary,
        bonus_pay,
        status,
        is_final_settlement
    ) VALUES (
        v_final_payroll_id,
        NEW.employee_id,
        DATE_TRUNC('month', NEW.last_working_date),
        NEW.last_working_date,
        v_employment_type,
        v_base_salary,
        0,
        'Pending',
        TRUE
    );

    RETURN NULL; 
END;
$$;


ALTER FUNCTION human_resources.generate_final_payroll() OWNER TO postgres;

--
-- Name: generate_job_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_job_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.job_id := 'JOB-' || to_char(CURRENT_DATE, 'YYYYMM') || '-' || 
                 lpad(floor(random() * 10000)::text, 4, '0');
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_job_id() OWNER TO postgres;

--
-- Name: generate_leave_balance_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_leave_balance_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.balance_id IS NULL THEN
        NEW.balance_id := 'LEAVE-BAL-' || NEW.employee_id || '-' || NEW.year;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_leave_balance_id() OWNER TO postgres;

--
-- Name: generate_position_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_position_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.position_id IS NULL THEN
        NEW.position_id := 
            CASE NEW.employment_type
                WHEN 'Regular' THEN 'REG-' || to_char(CURRENT_DATE, 'YYMM') || '-' || substr(md5(random()::text), 1, 4)
                WHEN 'Contractual' THEN 'CTR-' || to_char(CURRENT_DATE, 'YYMM') || '-' || substr(md5(random()::text), 1, 4)
                WHEN 'Seasonal' THEN 'SEA-' || to_char(CURRENT_DATE, 'YYMM') || '-' || substr(md5(random()::text), 1, 4)
            END;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_position_id() OWNER TO postgres;

--
-- Name: generate_resignation_id(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.generate_resignation_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    rand_text TEXT;
BEGIN
    rand_text := substring(md5(random()::text) from 1 for 5);

    NEW.resignation_id := 'RES-' || to_char(CURRENT_DATE, 'YYYYMMDD') || '-' || upper(rand_text);
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.generate_resignation_id() OWNER TO postgres;

--
-- Name: handle_leave_approval(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.handle_leave_approval() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    
    IF NEW.management_approval_id IS NOT NULL AND 
       (OLD.management_approval_id IS NULL OR OLD.management_approval_id != NEW.management_approval_id) THEN
        
        IF NOT EXISTS (
            SELECT 1 FROM management.approvals 
            WHERE approval_id = NEW.management_approval_id
        ) THEN
            RAISE EXCEPTION 'Invalid management approval reference: %', NEW.management_approval_id;
        END IF;
        
        SELECT 
            CASE WHEN status = 'Approved' THEN 'Approved by Management'
                 ELSE 'Rejected by Management' END
        INTO NEW.status
        FROM management.approvals
        WHERE approval_id = NEW.management_approval_id;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.handle_leave_approval() OWNER TO postgres;

--
-- Name: process_leave_request(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.process_leave_request() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.leave_id := 'LV-' || to_char(CURRENT_DATE, 'YYYYMM') || '-' || substr(md5(random()::text), 1, 6);
    
    IF NOT EXISTS (
        SELECT 1 FROM human_resources.employees 
        WHERE employee_id = NEW.employee_id AND employment_type = 'Regular'
    ) THEN
        RAISE EXCEPTION 'Only regular employees can request leave';
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.process_leave_request() OWNER TO postgres;

--
-- Name: process_resignation(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.process_resignation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Generate resignation ID
    NEW.resignation_id := 'RES-' || to_char(CURRENT_DATE, 'YYYYMM') || '-' || substr(md5(random()::text), 1, 6);
    
    -- Set default notice period based on employment type
    SELECT 
        CASE employment_type
            WHEN 'Regular' THEN 30
            WHEN 'Contractual' THEN 15
            WHEN 'Seasonal' THEN 7
        END
    INTO NEW.notice_period_days
    FROM human_resources.employees
    WHERE employee_id = NEW.employee_id;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.process_resignation() OWNER TO postgres;

--
-- Name: set_compensation_values(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.set_compensation_values() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.position_id IS NOT NULL THEN
        IF NEW.employment_type = 'Regular' THEN
            SELECT min_salary INTO NEW.base_salary 
            FROM human_resources.positions 
            WHERE position_id = NEW.position_id;
        ELSIF NEW.employment_type IN ('Contractual', 'Seasonal') THEN
            SELECT min_salary/22 INTO NEW.daily_rate -- Convert monthly to daily rate
            FROM human_resources.positions
            WHERE position_id = NEW.position_id;
            
            IF NEW.duration_days IS NULL THEN
                SELECT typical_duration_days INTO NEW.duration_days
                FROM human_resources.positions
                WHERE position_id = NEW.position_id;
            END IF;
        END IF;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.set_compensation_values() OWNER TO postgres;

--
-- Name: set_position_defaults(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.set_position_defaults() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    IF NEW.employment_type = 'Contractual' AND NEW.typical_duration_days IS NULL THEN
        NEW.typical_duration_days := 90; -- Default 3 months
    ELSIF NEW.employment_type = 'Seasonal' AND NEW.typical_duration_days IS NULL THEN
        NEW.typical_duration_days := 14; -- Default 2 weeks
    END IF;
    
    IF NEW.is_active IS NULL THEN
        NEW.is_active := TRUE;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.set_position_defaults() OWNER TO postgres;

--
-- Name: set_supervisor_flag(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.set_supervisor_flag() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.is_supervisor := EXISTS (
        SELECT 1 FROM human_resources.department_superiors ds
        WHERE ds.dept_id = NEW.dept_id AND ds.position_id = NEW.position_id
    );
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.set_supervisor_flag() OWNER TO postgres;

--
-- Name: sync_bpm_employee(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.sync_bpm_employee() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insert if not exists
    INSERT INTO admin.business_partner_master (employee_id, partner_name, category, contact_info)
    VALUES (NEW.employee_id, NEW.first_name || ' ' || NEW.last_name, 'Employee', COALESCE(NEW.phone, 'N/A'))
    ON CONFLICT (employee_id) DO UPDATE
    SET
        partner_name = EXCLUDED.partner_name,
        contact_info = EXCLUDED.contact_info;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.sync_bpm_employee() OWNER TO postgres;

--
-- Name: track_allocation_status(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.track_allocation_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.status = 'Submitted' AND OLD.status != 'Submitted' THEN
        NEW.submitted_at = CURRENT_TIMESTAMP;
    ELSIF NEW.approval_status = 'Approved' AND OLD.approval_status != 'Approved' THEN
        NEW.approved_at = CURRENT_TIMESTAMP;
    END IF;
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.track_allocation_status() OWNER TO postgres;

--
-- Name: update_employee_resignation(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.update_employee_resignation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.approval_status = 'Approved' AND OLD.approval_status != 'Approved' THEN
        UPDATE human_resources.employees
        SET 
            status = CASE 
                WHEN CURRENT_DATE < NEW.last_working_date THEN 'On Notice'
                ELSE 'Resigned' END,
            resignation_date = NEW.submission_date,
            last_working_date = NEW.last_working_date
        WHERE employee_id = NEW.employee_id;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.update_employee_resignation() OWNER TO postgres;

--
-- Name: update_employee_timestamp(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.update_employee_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.update_employee_timestamp() OWNER TO postgres;

--
-- Name: update_job_timestamps(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.update_job_timestamps() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    
    IF NEW.finance_approval_id IS NOT NULL AND 
       (OLD.finance_approval_id IS DISTINCT FROM NEW.finance_approval_id) THEN
        IF NOT EXISTS (
            SELECT 1 FROM finance.budget_submission 
            WHERE submission_id = NEW.finance_approval_id
        ) THEN
            RAISE EXCEPTION 'Invalid finance approval reference: %', NEW.finance_approval_id;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.update_job_timestamps() OWNER TO postgres;

--
-- Name: update_payroll_status(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.update_payroll_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;

    IF NEW.status = 'Processing' AND OLD.status != 'Processing' THEN
        NEW.status := 'Completed';
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.update_payroll_status() OWNER TO postgres;

--
-- Name: update_position_timestamp(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.update_position_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.update_position_timestamp() OWNER TO postgres;

--
-- Name: validate_finance_approval(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.validate_finance_approval() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.posting_status = 'Open' AND 
       (NEW.finance_approval_status != 'Approved' OR NEW.finance_approval_id IS NULL) THEN
        RAISE EXCEPTION 'Cannot open job posting without finance approval';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.validate_finance_approval() OWNER TO postgres;

--
-- Name: validate_leave_request(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.validate_leave_request() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_balance RECORD;
    fiscal_year INT := EXTRACT(YEAR FROM CURRENT_DATE);
BEGIN
    SELECT * INTO current_balance
    FROM human_resources.employee_leave_balances
    WHERE employee_id = NEW.employee_id AND year = fiscal_year;
    
    IF NOT FOUND THEN
        INSERT INTO human_resources.employee_leave_balances (employee_id)
        VALUES (NEW.employee_id)
        RETURNING * INTO current_balance;
    END IF;
    
    CASE NEW.leave_type
        WHEN 'Sick' THEN
            IF NEW.total_days > current_balance.sick_leave_remaining THEN
                RAISE EXCEPTION 'Insufficient sick leave balance. Remaining: % days', current_balance.sick_leave_remaining;
            END IF;
        WHEN 'Vacation' THEN
            IF NEW.total_days > current_balance.vacation_leave_remaining THEN
                RAISE EXCEPTION 'Insufficient vacation leave balance. Remaining: % days', current_balance.vacation_leave_remaining;
            END IF;
        WHEN 'Maternity' THEN
            IF NEW.total_days > 105 THEN
                RAISE EXCEPTION 'Maternity leave cannot exceed 105 days';
            END IF;
            IF NEW.total_days > current_balance.maternity_leave_remaining THEN
                RAISE EXCEPTION 'Insufficient maternity leave balance. Remaining: % days', current_balance.maternity_leave_remaining;
            END IF;
        WHEN 'Paternity' THEN
            IF NEW.total_days > 7 THEN
                RAISE EXCEPTION 'Paternity leave cannot exceed 7 days';
            END IF;
            IF NEW.total_days > current_balance.paternity_leave_remaining THEN
                RAISE EXCEPTION 'Insufficient paternity leave balance. Remaining: % days', current_balance.paternity_leave_remaining;
            END IF;
        WHEN 'Solo Parent' THEN
            IF NEW.total_days > 7 THEN
                RAISE EXCEPTION 'Solo parent leave cannot exceed 7 days per year';
            END IF;
            IF NEW.total_days > current_balance.solo_parent_leave_remaining THEN
                RAISE EXCEPTION 'Insufficient solo parent leave balance. Remaining: % days', current_balance.solo_parent_leave_remaining;
            END IF;
        ELSE
            NULL;
    END CASE;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.validate_leave_request() OWNER TO postgres;

--
-- Name: validate_salary(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.validate_salary() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
 emp_type TEXT;
BEGIN
    SELECT employment_type INTO emp_type 
    FROM human_resources.employees 
    WHERE employee_id = NEW.employee_id;
    
    NEW.salary_id := 'SAL-' || to_char(CURRENT_DATE, 'YYYYMM') || '-' || substr(md5(random()::text), 1, 6);
    
    IF emp_type = 'Regular' THEN
        IF NEW.base_salary IS NULL OR NEW.base_salary <= 0 THEN
            RAISE EXCEPTION 'Regular employees must have a positive base salary';
        END IF;

IF emp_type = 'Regular' AND (
    NEW.base_salary < (SELECT min_salary FROM human_resources.positions p 
                      JOIN human_resources.employees e ON p.position_id = e.position_id 
                      WHERE e.employee_id = NEW.employee_id)
    OR 
    NEW.base_salary > (SELECT max_salary FROM human_resources.positions p 
                      JOIN human_resources.employees e ON p.position_id = e.position_id 
                      WHERE e.employee_id = NEW.employee_id)
) THEN 
    RAISE EXCEPTION 'Base salary must be within position’s min/max range';
END IF;

        IF NEW.daily_rate IS NOT NULL OR NEW.contract_start_date IS NOT NULL OR NEW.contract_end_date IS NOT NULL THEN
            RAISE EXCEPTION 'Regular employees should not have daily rates or contract dates';
        END IF;
    ELSIF emp_type IN ('Contractual', 'Seasonal') THEN
        IF NEW.daily_rate IS NULL OR NEW.daily_rate <= 0 THEN
            RAISE EXCEPTION 'Contractual/Seasonal employees must have a positive daily rate';
        END IF;
        IF NEW.contract_start_date IS NULL OR NEW.contract_end_date IS NULL OR NEW.contract_end_date <= NEW.contract_start_date THEN
            RAISE EXCEPTION 'Contractual/Seasonal employees require valid contract dates';
        END IF;
        IF NEW.base_salary IS NOT NULL THEN
            RAISE EXCEPTION 'Contractual/Seasonal employees should not have a base salary';
        END IF;
    END IF;
    
    NEW.updated_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.validate_salary() OWNER TO postgres;

--
-- Name: validate_superior(); Type: FUNCTION; Schema: human_resources; Owner: postgres
--

CREATE FUNCTION human_resources.validate_superior() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.reports_to IS NOT NULL THEN
        -- Check if the superior exists and is in the same department
        IF NOT EXISTS (
            SELECT 1 FROM human_resources.employees sup
            WHERE sup.employee_id = NEW.reports_to
            AND sup.dept_id = NEW.dept_id
            AND sup.is_supervisor = TRUE  -- Ensure they're marked as supervisor
        ) THEN
            RAISE EXCEPTION 'Invalid superior: Must be a supervisor in the same department';
        END IF;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION human_resources.validate_superior() OWNER TO postgres;

--
-- Name: generate_adjustment_id(); Type: FUNCTION; Schema: inventory; Owner: postgres
--

CREATE FUNCTION inventory.generate_adjustment_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IA'; 
    module_name TEXT := 'INV';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.adjustment_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION inventory.generate_adjustment_id() OWNER TO postgres;

--
-- Name: generate_deprecation_report_id(); Type: FUNCTION; Schema: inventory; Owner: postgres
--

CREATE FUNCTION inventory.generate_deprecation_report_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'DR'; 
    module_name TEXT := 'INV';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.deprecation_report_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION inventory.generate_deprecation_report_id() OWNER TO postgres;

--
-- Name: generate_expiry_report_id(); Type: FUNCTION; Schema: inventory; Owner: postgres
--

CREATE FUNCTION inventory.generate_expiry_report_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ER'; 
    module_name TEXT := 'INV';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.expiry_report_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION inventory.generate_expiry_report_id() OWNER TO postgres;

--
-- Name: generate_inventory_count_id(); Type: FUNCTION; Schema: inventory; Owner: postgres
--

CREATE FUNCTION inventory.generate_inventory_count_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ICC'; 
    module_name TEXT := 'INV';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.inventory_count_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION inventory.generate_inventory_count_id() OWNER TO postgres;

--
-- Name: generate_inventory_item_id(); Type: FUNCTION; Schema: inventory; Owner: postgres
--

CREATE FUNCTION inventory.generate_inventory_item_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'II'; 
    module_name TEXT := 'INV';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.inventory_item_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION inventory.generate_inventory_item_id() OWNER TO postgres;

--
-- Name: generate_movement_id(); Type: FUNCTION; Schema: inventory; Owner: postgres
--

CREATE FUNCTION inventory.generate_movement_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'WM'; 
    module_name TEXT := 'INV';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.movement_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION inventory.generate_movement_id() OWNER TO postgres;

--
-- Name: inventory_item_threshold_id(); Type: FUNCTION; Schema: inventory; Owner: postgres
--

CREATE FUNCTION inventory.inventory_item_threshold_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IITH'; 
    module_name TEXT := 'INV';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.inventory_item_threshold_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION inventory.inventory_item_threshold_id() OWNER TO postgres;

--
-- Name: generate_approval_id(); Type: FUNCTION; Schema: management; Owner: postgres
--

CREATE FUNCTION management.generate_approval_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code VARCHAR(6);
BEGIN
    SELECT substring(md5(random()::text), 1, 6) INTO unique_code;
    NEW.approval_id := 'MGT-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION management.generate_approval_id() OWNER TO postgres;

--
-- Name: generate_bom_id(); Type: FUNCTION; Schema: mrp; Owner: postgres
--

CREATE FUNCTION mrp.generate_bom_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BOM'; 
    module_name TEXT := 'MRP';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.bom_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION mrp.generate_bom_id() OWNER TO postgres;

--
-- Name: generate_labor_cost_id(); Type: FUNCTION; Schema: mrp; Owner: postgres
--

CREATE FUNCTION mrp.generate_labor_cost_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'LC';  
    module_name TEXT := 'MRP';   
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    
    NEW.labor_cost_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION mrp.generate_labor_cost_id() OWNER TO postgres;

--
-- Name: generate_non_project_costing_id(); Type: FUNCTION; Schema: mrp; Owner: postgres
--

CREATE FUNCTION mrp.generate_non_project_costing_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'NPC'; 
    module_name TEXT := 'MRP';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.non_project_costing_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION mrp.generate_non_project_costing_id() OWNER TO postgres;

--
-- Name: generate_principal_item_id(); Type: FUNCTION; Schema: mrp; Owner: postgres
--

CREATE FUNCTION mrp.generate_principal_item_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PI'; 
    module_name TEXT := 'MRP';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.principal_item_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION mrp.generate_principal_item_id() OWNER TO postgres;

--
-- Name: generate_product_material_id(); Type: FUNCTION; Schema: mrp; Owner: postgres
--

CREATE FUNCTION mrp.generate_product_material_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PM'; 
    module_name TEXT := 'MRP';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.product_mats_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION mrp.generate_product_material_id() OWNER TO postgres;

--
-- Name: generate_ar_credit_memo_id(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_ar_credit_memo_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    memo_date TEXT;
    memo_count TEXT;
BEGIN
    memo_date := to_char(CURRENT_DATE, 'YYYYMMDD');
    memo_count := LPAD(nextval('operations.ar_credit_memo_seq')::TEXT, 4, '0');
    NEW.ar_credit_memo := 'ARC' || memo_date || '-' || memo_count;
    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_ar_credit_memo_id() OWNER TO postgres;

--
-- Name: generate_asset_serial(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_asset_serial() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN

    NEW.serial_no := 'KNTP' || LPAD(nextval('operations.asset_serial_seq')::TEXT, 4, '0');
    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_asset_serial() OWNER TO postgres;

--
-- Name: generate_batch_number(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_batch_number() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    batch_date TEXT;
    batch_count TEXT;
BEGIN
    -- Generate batch number
    batch_date := to_char(CURRENT_DATE, 'YYYYMMDD');
    batch_count := LPAD(nextval('operations.batch_number_seq')::TEXT, 4, '0');
    NEW.batch_no := 'BN' || batch_date || '-' || batch_count;

    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_batch_number() OWNER TO postgres;

--
-- Name: generate_content_id(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_content_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'DOI'; 
    module_name TEXT := 'OPS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.content_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_content_id() OWNER TO postgres;

--
-- Name: generate_document_id(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_document_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'DOH'; 
    module_name TEXT := 'OPS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.document_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_document_id() OWNER TO postgres;

--
-- Name: generate_external_id(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_external_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EXM'; 
    module_name TEXT := 'OPS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.external_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_external_id() OWNER TO postgres;

--
-- Name: generate_productdocu_id(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_productdocu_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PDI'; 
    module_name TEXT := 'OPS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.productdocu_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_productdocu_id() OWNER TO postgres;

--
-- Name: generate_serial_id(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.generate_serial_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SET'; 
    module_name TEXT := 'OPS';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.serial_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.generate_serial_id() OWNER TO postgres;

--
-- Name: handle_external_module_update(); Type: FUNCTION; Schema: operations; Owner: postgres
--

CREATE FUNCTION operations.handle_external_module_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Insert a new row into document_items with only external_id
    INSERT INTO operations.document_items (external_id)
    VALUES (NEW.external_id)
    ON CONFLICT (external_id) DO NOTHING; -- Avoid duplicate inserts

    RETURN NEW;
END;
$$;


ALTER FUNCTION operations.handle_external_module_update() OWNER TO postgres;

--
-- Name: generate_equipment_id(); Type: FUNCTION; Schema: production; Owner: postgres
--

CREATE FUNCTION production.generate_equipment_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EQP'; 
    module_name TEXT := 'PROD';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.equipment_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION production.generate_equipment_id() OWNER TO postgres;

--
-- Name: generate_labor_id(); Type: FUNCTION; Schema: production; Owner: postgres
--

CREATE FUNCTION production.generate_labor_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'LAB'; 
    module_name TEXT := 'PROD';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.labor_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION production.generate_labor_id() OWNER TO postgres;

--
-- Name: generate_production_order_detail_id(); Type: FUNCTION; Schema: production; Owner: postgres
--

CREATE FUNCTION production.generate_production_order_detail_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'POD'; 
    module_name TEXT := 'PROD';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.production_order_detail_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION production.generate_production_order_detail_id() OWNER TO postgres;

--
-- Name: generate_production_order_id(); Type: FUNCTION; Schema: production; Owner: postgres
--

CREATE FUNCTION production.generate_production_order_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PO'; 
    module_name TEXT := 'PROD';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.production_order_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION production.generate_production_order_id() OWNER TO postgres;

--
-- Name: generate_project_equipment_id(); Type: FUNCTION; Schema: production; Owner: postgres
--

CREATE FUNCTION production.generate_project_equipment_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PJEQ'; 
    module_name TEXT := 'PROD';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_equipment_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION production.generate_project_equipment_id() OWNER TO postgres;

--
-- Name: generate_rework_cost_id(); Type: FUNCTION; Schema: production; Owner: postgres
--

CREATE FUNCTION production.generate_rework_cost_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ 
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'RWC'; 
    module_name TEXT := 'PROD';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.rework_cost_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION production.generate_rework_cost_id() OWNER TO postgres;

--
-- Name: calculate_product_pricing(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_product_pricing() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    base_price DECIMAL(10, 2); 
BEGIN
    -- Retrieve the quotation type directly
    SELECT selling_price INTO base_price FROM admin.products WHERE product_id = NEW.admin_product_id;
    NEW.selling_price := ROUND(base_price * (1 + (NEW.markup_percentage / 100)), 2);
    IF TG_OP = 'UPDATE' AND NEW.demand_level <> OLD.demand_level THEN
        NEW.markup_percentage := CASE
        WHEN NEW.demand_level = 'Very High'::demand_level_enum THEN 100.00
        WHEN NEW.demand_level = 'High'::demand_level_enum THEN 80.00
        WHEN NEW.demand_level = 'Medium'::demand_level_enum THEN 60.00
        WHEN NEW.demand_level = 'Low'::demand_level_enum THEN 20.00
        ELSE 20.00
        END;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.calculate_product_pricing() OWNER TO postgres;

--
-- Name: check_assignment_overlap(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_assignment_overlap() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM human_resources.workforce_allocation
        WHERE employee_id = NEW.employee_id
        AND status = 'Active'
        AND (
            (start_date BETWEEN NEW.start_date AND NEW.end_date) OR
            (end_date BETWEEN NEW.start_date AND NEW.end_date) OR
            (NEW.start_date BETWEEN start_date AND end_date)
        )
    )THEN
        RAISE EXCEPTION 'Employee already has an active assignment during this period';
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_assignment_overlap() OWNER TO postgres;

--
-- Name: create_product_pricing(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_product_pricing() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO sales.product_pricing (admin_product_id) VALUES (NEW.product_id);
	RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_product_pricing() OWNER TO postgres;

--
-- Name: generate_external_project_details_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_external_project_details_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPD'; 
    module_name TEXT := UPPER(LEFT('project_management', 4));          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_external_project_details_id() OWNER TO postgres;

--
-- Name: generate_external_project_labor_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_external_project_labor_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPL'; 
    module_name TEXT := UPPER(LEFT('project_management', 4));          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_labor_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_external_project_labor_id() OWNER TO postgres;

--
-- Name: generate_external_project_request_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_external_project_request_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPR'; 
    module_name TEXT := UPPER(LEFT('project_management', 4));          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.ext_project_request_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_external_project_request_id() OWNER TO postgres;

--
-- Name: generate_external_project_resources_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_external_project_resources_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPRM'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_resources_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_external_project_resources_id() OWNER TO postgres;

--
-- Name: generate_external_project_task_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_external_project_task_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPT'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.task_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_external_project_task_id() OWNER TO postgres;

--
-- Name: generate_external_project_tracking_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_external_project_tracking_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPTK'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_tracking_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_external_project_tracking_id() OWNER TO postgres;

--
-- Name: generate_external_project_warranty_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_external_project_warranty_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPW'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_warranty_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_external_project_warranty_id() OWNER TO postgres;

--
-- Name: generate_internal_project_details_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_internal_project_details_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IPD'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.intrnl_project_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_internal_project_details_id() OWNER TO postgres;

--
-- Name: generate_internal_project_labor_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_internal_project_labor_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IPL'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.intrnl_project_labor_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_internal_project_labor_id() OWNER TO postgres;

--
-- Name: generate_internal_project_request_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_internal_project_request_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IPR'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_request_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_internal_project_request_id() OWNER TO postgres;

--
-- Name: generate_internal_project_task_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_internal_project_task_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IPT'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.intrnl_task_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_internal_project_task_id() OWNER TO postgres;

--
-- Name: generate_internal_project_tracking_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_internal_project_tracking_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IPT'; 
    module_name TEXT := 'PROJ';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.intrnl_project_tracking_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_internal_project_tracking_id() OWNER TO postgres;

--
-- Name: generate_intrnl_project_resources_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_intrnl_project_resources_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'IPC'; 
    module_name TEXT := UPPER(LEFT('project_management', 4));          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.intrnl_project_resources_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_intrnl_project_resources_id() OWNER TO postgres;

--
-- Name: generate_product_pricing_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_product_pricing_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PRDP'; 
    module_name TEXT := UPPER(LEFT('sales', 4));          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.product_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_product_pricing_id() OWNER TO postgres;

--
-- Name: generate_project_equipment_list_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_project_equipment_list_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'EPE'; 
    module_name TEXT := UPPER(LEFT('project_management', 4));          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.project_equipment_list_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_project_equipment_list_id() OWNER TO postgres;

--
-- Name: generate_report_monitoring_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_report_monitoring_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'RPM'; 
    module_name TEXT := UPPER(LEFT('project_management', 4));          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.report_monitoring_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.generate_report_monitoring_id() OWNER TO postgres;

--
-- Name: insert_into_official_receipts(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_into_official_receipts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE
    payment_method_value payment_method_enum;
    customer_id_value VARCHAR(255);
    settled_amount_value DECIMAL(10,2);
    remaining_amount_value DECIMAL(10,2);
BEGIN
    -- Retrieve the payment method from the sales.payments table
    SELECT payment_method INTO payment_method_value
    FROM sales.payments
    WHERE order_id = NEW.order_id
    LIMIT 1;

    -- Retrieve the customer ID by joining sales_invoices, orders, and statement tables
    SELECT s.customer_id INTO customer_id_value
    FROM sales.sales_invoices si
    JOIN sales.orders o ON si.order_id = o.order_id
    JOIN sales.statement s ON o.statement_id = s.statement_id
    WHERE si.invoice_id = NEW.invoice_id;

    -- Determine settled_amount and remaining_amount based on invoice_status and payment_status
    IF NEW.invoice_status = 'Paid' AND NEW.payment_status = 'Completed' THEN
        settled_amount_value := NEW.total_amount;
        remaining_amount_value := 0;
    ELSE
        settled_amount_value := 0;
        remaining_amount_value := NEW.total_amount;
    END IF;

    INSERT INTO accounting.official_receipts (
         invoice_id, customer_id, or_date, settled_amount, remaining_amount, payment_method, reference_number, created_by
    ) VALUES (
        -- Generate random OR ID
        NEW.invoice_id,
        customer_id_value, -- Get customer ID from the joined tables
        CURRENT_DATE,
        settled_amount_value,
        remaining_amount_value,
        payment_method_value, -- Use the actual payment method from payments table
        CONCAT('REF-', SUBSTRING(MD5(random()::text) FROM 1 FOR 6)), -- Random reference number
        'Admin'
    );

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.insert_into_official_receipts() OWNER TO postgres;

--
-- Name: insert_order_based_on_type(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.insert_order_based_on_type() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    ext_id VARCHAR(255);
BEGIN
    -- Insert into the correct table based on quotation type
    IF NEW.order_type = 'Non-Project-Based'::order_type_enum THEN
        INSERT INTO mrp.non_project_order_pricing (order_id, final_price)
	VALUES (NEW.order_id, 0.00);
    
    ELSIF NEW.order_type = 'Project-Based'::order_type_enum THEN
        INSERT INTO project_management.external_project_request (ext_project_request_id, ext_project_name, ext_project_description, approval_id, item_id)
        VALUES (NEW.order_id, 'Project for Order ' || NEW.order_id, 'Automatically generated project request', NULL, NEW.order_id) RETURNING ext_project_request_id INTO ext_id;

        UPDATE sales.orders SET ext_project_request_id = ext_id WHERE order_id = NEW.order_id;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.insert_order_based_on_type() OWNER TO postgres;

--
-- Name: update_demand_level(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_demand_level() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Compute total quantity sold per product and rank using NTILE
    WITH demand_ranking AS (
        SELECT product_id,
               SUM(quantity) AS total_quantity,
               NTILE(10) OVER (ORDER BY SUM(quantity) DESC) AS demand_rank
        FROM sales.statement_item
        GROUP BY product_id
    ),
    recent_sales AS (
        SELECT product_id,
               SUM(quantity) AS recent_quantity
        FROM sales.statement_item
        WHERE created_at >= NOW() - INTERVAL '60 days'
        GROUP BY product_id
    ),
    total_sales AS (
        SELECT product_id, SUM(quantity) AS total_quantity
        FROM sales.statement_item
        GROUP BY product_id
    )
    UPDATE sales.product_pricing pp
    SET demand_level = CASE
        WHEN dr.demand_rank <= 1 THEN 'Very High'::demand_level_enum
        WHEN dr.demand_rank <= 3 THEN 'High'::demand_level_enum
        WHEN dr.demand_rank BETWEEN 4 AND 7 THEN 'Medium'::demand_level_enum
        WHEN dr.demand_rank BETWEEN 8 AND 10 THEN 'Low'::demand_level_enum
        WHEN rs.recent_quantity >= 0.9 * ts.total_quantity THEN 'Seasonal'::demand_level_enum
    END
    FROM demand_ranking dr
    LEFT JOIN recent_sales rs ON dr.product_id = rs.product_id
    LEFT JOIN total_sales ts ON dr.product_id = ts.product_id
    WHERE pp.admin_product_id = dr.product_id;

    RETURN NULL;
END;
$$;


ALTER FUNCTION public.update_demand_level() OWNER TO postgres;

--
-- Name: update_leave_balances(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_leave_balances() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.status = 'Approved by Management' AND OLD.status != 'Approved by Management' THEN
        UPDATE human_resources.employee_leave_balances
        SET 
            sick_leave_remaining = CASE 
                WHEN NEW.leave_type = 'Sick' THEN GREATEST(0, sick_leave_remaining - NEW.total_days)
                ELSE sick_leave_remaining END,
            vacation_leave_remaining = CASE 
                WHEN NEW.leave_type = 'Vacation' THEN GREATEST(0, vacation_leave_remaining - NEW.total_days)
                ELSE vacation_leave_remaining END,
            unpaid_leave_taken = CASE
                WHEN NEW.is_paid = FALSE THEN unpaid_leave_taken + NEW.total_days
                ELSE unpaid_leave_taken END
        WHERE employee_id = NEW.employee_id AND year = EXTRACT(YEAR FROM NEW.start_date);
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_leave_balances() OWNER TO postgres;

--
-- Name: update_timestamp(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_timestamp() OWNER TO postgres;

--
-- Name: auto_insert_vendor(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.auto_insert_vendor() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.status = 'Approved' THEN
        -- Check if vendor already exists for this application_reference
        IF NOT EXISTS (SELECT 1 FROM admin.vendor WHERE application_reference = NEW.application_reference) THEN
            INSERT INTO admin.vendor (
                vendor_code,
                application_reference,
                vendor_name,
                contact_person,
                status
            ) VALUES (
                NULL,
                NEW.application_reference,
                NEW.company_name,
                NEW.contact_person,
                'Active'
            );
        END IF;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.auto_insert_vendor() OWNER TO postgres;

--
-- Name: generate_application_reference(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_application_reference() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'VEP'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.application_reference := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_application_reference() OWNER TO postgres;

--
-- Name: generate_credit_memo_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_credit_memo_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CRM'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.credit_memo_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_credit_memo_id() OWNER TO postgres;

--
-- Name: generate_inspection_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_inspection_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BAI'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.inspection_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_inspection_id() OWNER TO postgres;

--
-- Name: generate_invoice_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_invoice_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PUI'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.invoice_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_invoice_id() OWNER TO postgres;

--
-- Name: generate_purchase_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_purchase_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PUO'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.purchase_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_purchase_id() OWNER TO postgres;

--
-- Name: generate_quotation_content_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_quotation_content_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'QUC'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.quotation_content_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_quotation_content_id() OWNER TO postgres;

--
-- Name: generate_quotation_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_quotation_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PUQ'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.quotation_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_quotation_id() OWNER TO postgres;

--
-- Name: generate_request_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_request_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PUR'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.request_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_request_id() OWNER TO postgres;

--
-- Name: generate_shipment_id(); Type: FUNCTION; Schema: purchasing; Owner: postgres
--

CREATE FUNCTION purchasing.generate_shipment_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'RES'; 
    module_name TEXT := 'PURCHASING';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.shipment_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION purchasing.generate_shipment_id() OWNER TO postgres;

--
-- Name: create_business_partner(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.create_business_partner() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_partner_id VARCHAR(255);
BEGIN
    INSERT INTO admin.business_partner_master (customer_id, partner_name, category, contact_info)
    VALUES (NEW.customer_id, NEW.name, 'Customer', NEW.phone_number)
    RETURNING partner_id INTO new_partner_id;
	
    UPDATE sales.customers SET partner_id = new_partner_id
    WHERE  customer_id = NEW.customer_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.create_business_partner() OWNER TO postgres;

--
-- Name: create_gl_account(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.create_gl_account() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_gl_account_id VARCHAR (255);
BEGIN
    INSERT INTO accounting.general_ledger_accounts (account_id, account_name, account_code, status)
    VALUES (NEW.customer_id, NEW.name,'ACC-COA-2025-CA1030','Active')
    RETURNING gl_account_id INTO new_gl_account_id;
    
    UPDATE sales.customers SET gl_account_id = new_gl_account_id WHERE customer_id = NEW.customer_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.create_gl_account() OWNER TO postgres;

--
-- Name: generate_agreement_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_agreement_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'AGRMNT'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.agreement_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_agreement_id() OWNER TO postgres;

--
-- Name: generate_campaign_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_campaign_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CMPGN'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.campaign_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_campaign_id() OWNER TO postgres;

--
-- Name: generate_contact_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_contact_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CONTACT'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.contact_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_contact_id() OWNER TO postgres;

--
-- Name: generate_convo_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_convo_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CONVO'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.convo_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_convo_id() OWNER TO postgres;

--
-- Name: generate_customer_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_customer_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CUST'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.customer_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_customer_id() OWNER TO postgres;

--
-- Name: generate_delivery_note_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_delivery_note_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SHIP'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.delivery_note_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_delivery_note_id() OWNER TO postgres;

--
-- Name: generate_invoice(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_invoice() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
  amount DECIMAL(10, 2);
BEGIN 
    SELECT total_amount INTO amount FROM sales.statement WHERE statement_id = NEW.statement_id;
    INSERT INTO sales.sales_invoices(delivery_note_id, total_amount)
    VALUES (NEW.delivery_note_id, amount);

    UPDATE sales.statement_item si_order
		SET quantity_to_deliver = quantity_to_deliver + delivery_data.quantity
		FROM (
		    SELECT o.statement_id AS order_statement_id, 
		           si_delivery.product_id, 
		           si_delivery.quantity,
                   d.delivery_note_id
		    FROM sales.delivery_note d
		    JOIN sales.orders o ON d.order_id = o.order_id
		    JOIN sales.statement s_order ON o.statement_id = s_order.statement_id
		    JOIN sales.statement s_delivery ON d.statement_id = s_delivery.statement_id
		    JOIN sales.statement_item si_delivery 
		        ON s_delivery.statement_id = si_delivery.statement_id WHERE d.order_id = NEW.order_id
		) AS delivery_data
		WHERE si_order.statement_id = delivery_data.order_statement_id
		AND si_order.product_id = delivery_data.product_id AND delivery_data.delivery_note_id = NEW.delivery_note_id;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_invoice() OWNER TO postgres;

--
-- Name: generate_invoice_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_invoice_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'INV'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.invoice_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_invoice_id() OWNER TO postgres;

--
-- Name: generate_opportunity_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_opportunity_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'OPP'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.opportunity_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_opportunity_id() OWNER TO postgres;

--
-- Name: generate_order_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_order_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ORD'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.order_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_order_id() OWNER TO postgres;

--
-- Name: generate_payment_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_payment_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'PAY'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.payment_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_payment_id() OWNER TO postgres;

--
-- Name: generate_quotation_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_quotation_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'QT'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.quotation_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_quotation_id() OWNER TO postgres;

--
-- Name: generate_return_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_return_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'RTN'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.return_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_return_id() OWNER TO postgres;

--
-- Name: generate_statement_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_statement_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'STM'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.statement_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_statement_id() OWNER TO postgres;

--
-- Name: generate_statement_item_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_statement_item_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'STI'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.statement_item_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_statement_item_id() OWNER TO postgres;

--
-- Name: generate_ticket_id(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.generate_ticket_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'TICKET'; 
    module_name TEXT := 'SALES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.ticket_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.generate_ticket_id() OWNER TO postgres;

--
-- Name: sync_bpm_customer(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.sync_bpm_customer() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    INSERT INTO admin.business_partner_master (customer_id, partner_name, category, contact_info)
    VALUES (NEW.customer_id, NEW.name, 'Customer', NEW.phone_number)
    ON CONFLICT (customer_id) DO UPDATE
    SET
        partner_name = EXCLUDED.partner_name,
        contact_info = EXCLUDED.contact_info;
    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.sync_bpm_customer() OWNER TO postgres;

--
-- Name: update_delivery_status(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.update_delivery_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Update delivery_note when shipment details changes
    UPDATE sales.delivery_note
    SET shipment_status = NEW.shipment_status, 
	tracking_num = NEW.tracking_number, 
	shipping_date = NEW.shipment_date, 
	estimated_delivery = NEW.estimated_arrival_date, 
	actual_delivery_date = NEW.actual_arrival_date
    WHERE shipment_id = NEW.shipment_id;

    RETURN NEW;
END;
$$;


ALTER FUNCTION sales.update_delivery_status() OWNER TO postgres;

--
-- Name: update_order_delivery(); Type: FUNCTION; Schema: sales; Owner: postgres
--

CREATE FUNCTION sales.update_order_delivery() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
   tracking_no VARCHAR(255);
   shipped_date TIMESTAMP;
   est_delivery TIMESTAMP;
   shipping_cost DECIMAL(10,2);
   status shipment_status_type;
   qty_delivered DECIMAL(10, 2);
BEGIN
   IF OLD.shipment_id IS NULL AND NEW.shipment_id is NOT NULL THEN 
       SELECT sd.tracking_number, sd.shipment_date, sd.estimated_arrival_date, sc.total_shipping_cost, sd.shipment_status INTO 
       tracking_no, shipped_date, est_delivery, shipping_cost, status
        FROM distribution.shipment_details sd 
        INNER JOIN distribution.shipping_cost sc ON sd.shipping_cost_id = sc.shipping_cost_id 
        WHERE sd.shipment_id = NEW.shipment_id;
       
       UPDATE sales.delivery_note SET 
	   shipment_status = status, 
	   tracking_num = tracking_no, 
	   shipping_date = shipped_date, 
	   estimated_delivery = est_delivery 
        WHERE delivery_note_id = NEW.delivery_note_id;
       
       UPDATE sales.sales_invoices SET total_amount = COALESCE(total_amount, 0) + shipping_cost 
        WHERE delivery_note_id = NEW.delivery_note_id;
   ELSIF OLD.shipment_status <> 'Delivered'::shipment_status_type AND NEW.shipment_status = 'Delivered'::shipment_status_type THEN 
   		UPDATE sales.statement_item si_order
		SET quantity_delivered = quantity_delivered + delivery_data.quantity
		FROM (
		    SELECT o.statement_id AS order_statement_id, 
		           si_delivery.product_id, 
		           si_delivery.quantity,
                   d.delivery_note_id
		    FROM sales.delivery_note d
		    JOIN sales.orders o ON d.order_id = o.order_id
		    JOIN sales.statement s_order ON o.statement_id = s_order.statement_id
		    JOIN sales.statement s_delivery ON d.statement_id = s_delivery.statement_id
		    JOIN sales.statement_item si_delivery 
		        ON s_delivery.statement_id = si_delivery.statement_id WHERE d.order_id = NEW.order_id
		) AS delivery_data
		WHERE si_order.statement_id = delivery_data.order_statement_id
		AND si_order.product_id = delivery_data.product_id AND delivery_data.delivery_note_id = NEW.delivery_note_id;
   END IF;
   RETURN NEW;
END;
$$;


ALTER FUNCTION sales.update_order_delivery() OWNER TO postgres;

--
-- Name: generate_additional_service_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_additional_service_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ADDSER'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.additional_service_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_additional_service_id() OWNER TO postgres;

--
-- Name: generate_additional_service_type_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_additional_service_type_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ADDSERTYPE'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.additional_service_type_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_additional_service_type_id() OWNER TO postgres;

--
-- Name: generate_analysis_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_analysis_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'ANALYSIS'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.analysis_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_analysis_id() OWNER TO postgres;

--
-- Name: generate_analysis_sched_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_analysis_sched_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SCHED'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.analysis_sched_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_analysis_sched_id() OWNER TO postgres;

--
-- Name: generate_delivery_order_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_delivery_order_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'DO'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.delivery_order_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_delivery_order_id() OWNER TO postgres;

--
-- Name: generate_renewal_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_renewal_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'RENEW'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.renewal_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_renewal_id() OWNER TO postgres;

--
-- Name: generate_report_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_report_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'REPORT'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.report_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_report_id() OWNER TO postgres;

--
-- Name: generate_service_billing_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_service_billing_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'BILL'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.service_billing_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_service_billing_id() OWNER TO postgres;

--
-- Name: generate_service_call_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_service_call_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'CALL'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.service_call_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_service_call_id() OWNER TO postgres;

--
-- Name: generate_service_contract_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_service_contract_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SERCON'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.contract_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_service_contract_id() OWNER TO postgres;

--
-- Name: generate_service_order_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_service_order_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SO'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.service_order_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_service_order_id() OWNER TO postgres;

--
-- Name: generate_service_order_item_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_service_order_item_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SOIT'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.service_order_item_id := module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_service_order_item_id() OWNER TO postgres;

--
-- Name: generate_service_request_id(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.generate_service_request_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    unique_code TEXT;
    module_prefix TEXT := 'SR'; 
    module_name TEXT := 'SERVICES';          
BEGIN
    unique_code := substr(md5(random()::text), 1, 6);
    NEW.service_request_id := module_name || '-' || module_prefix || '-' || to_char(CURRENT_DATE, 'YYYY') || '-' || unique_code;
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.generate_service_request_id() OWNER TO postgres;

--
-- Name: update_end_date_trigger(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.update_end_date_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- update renewal dates
    IF NEW.renewal_id IS NOT NULL THEN
        SELECT renewal_warranty_start, renewal_warranty_end
        INTO NEW.renewal_date, NEW.renewal_end_date
        FROM services.warranty_renewal
        WHERE renewal_id = NEW.renewal_id;
    END IF;

    -- update end_date only if renewal_end_date is provided
    IF NEW.renewal_end_date IS NOT NULL THEN
        NEW.end_date := NEW.renewal_end_date;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION services.update_end_date_trigger() OWNER TO postgres;

--
-- Name: update_renewal_fee_and_end(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.update_renewal_fee_and_end() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_selling_price DECIMAL(10,2);
BEGIN
    -- Get selling_price by joining through contract_id → product_id
    SELECT p.selling_price
    INTO v_selling_price
    FROM services.service_contract sc
    JOIN admin.products p ON sc.product_id = p.product_id
    WHERE sc.contract_id = NEW.contract_id;

    -- Compute renewal_fee
    NEW.renewal_fee := (v_selling_price * 0.20) * NEW.duration;
-- set renewal_warranty_end
    NEW.renewal_warranty_end := NEW.renewal_warranty_start + make_interval(years => NEW.duration);

    RETURN NEW;
END;
$$;


ALTER FUNCTION services.update_renewal_fee_and_end() OWNER TO postgres;

--
-- Name: update_service_billing(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.update_service_billing() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
    v_order_total_price DECIMAL(10,2) := 0.00;
    v_labor_cost DECIMAL(10,2) := 0.00;
    v_total_operational_cost DECIMAL(10,2) := 0.00;
    v_renewal_fee DECIMAL(10,2) := 0.00;
BEGIN
    -- Get renewal_fee if renewal_id is present
    IF NEW.renewal_id IS NOT NULL THEN
        SELECT COALESCE(renewal_fee, 0.00)
        INTO v_renewal_fee 
        FROM services.warranty_renewal
        WHERE renewal_id = NEW.renewal_id;

        -- Set total_payable to renewal_fee only
        NEW.total_payable := v_renewal_fee;

        -- Optionally set service_billing_amount to 0 or renewal_fee depending on your business rule
        NEW.service_billing_amount := 0.00; -- or := v_renewal_fee;

        RETURN NEW;
    END IF;

    -- If not renewal, proceed with normal calculations

    IF NEW.service_order_id IS NOT NULL THEN
        SELECT COALESCE(order_total_price, 0.00)
        INTO v_order_total_price
        FROM services.service_order
        WHERE service_order_id = NEW.service_order_id;
    END IF;

    IF NEW.analysis_id IS NOT NULL THEN
        SELECT COALESCE(labor_cost, 0.00)
        INTO v_labor_cost
        FROM services.service_analysis
        WHERE analysis_id = NEW.analysis_id;
    END IF;

    IF NEW.operational_cost_id IS NOT NULL THEN
        SELECT COALESCE(total_operational_cost, 0.00)
        INTO v_total_operational_cost
        FROM distribution.operational_cost
        WHERE operational_cost_id = NEW.operational_cost_id;
    END IF;

    NEW.service_billing_amount := v_order_total_price + v_labor_cost;
    NEW.total_payable := NEW.service_billing_amount + v_total_operational_cost + COALESCE(NEW.outsource_fee, 0.00);

    RETURN NEW;
END;
$$;


ALTER FUNCTION services.update_service_billing() OWNER TO postgres;

--
-- Name: update_service_order_item_prices(); Type: FUNCTION; Schema: services; Owner: postgres
--

CREATE FUNCTION services.update_service_order_item_prices() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    principal_markup_price DECIMAL(10,2);
BEGIN

    IF NEW.principal_item_id IS NOT NULL THEN
        -- get mark_up_price from principal_items
        SELECT mark_up_price
        INTO principal_markup_price 
        FROM mrp.principal_items
        WHERE principal_item_id = NEW.principal_item_id;

        NEW.item_price := principal_markup_price;
        NEW.total_price := principal_markup_price * NEW.item_quantity;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION services.update_service_order_item_prices() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: chart_of_accounts; Type: TABLE; Schema: accounting; Owner: postgres
--

CREATE TABLE accounting.chart_of_accounts (
    account_code character varying(255) NOT NULL,
    account_name character varying(255) NOT NULL,
    account_type character varying(50) DEFAULT NULL::character varying
);


ALTER TABLE accounting.chart_of_accounts OWNER TO postgres;

--
-- Name: financial_report; Type: TABLE; Schema: accounting; Owner: postgres
--

CREATE TABLE accounting.financial_report (
    report_id character varying(255) NOT NULL,
    report_type character varying(255) NOT NULL,
    total_cost numeric(15,2) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    generated_by character varying(255) NOT NULL
);


ALTER TABLE accounting.financial_report OWNER TO postgres;

--
-- Name: general_ledger_accounts; Type: TABLE; Schema: accounting; Owner: postgres
--

CREATE TABLE accounting.general_ledger_accounts (
    gl_account_id character varying(255) NOT NULL,
    account_name character varying(255) NOT NULL,
    account_code character varying(255) NOT NULL,
    account_id character varying(255),
    status public.status_enum NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE accounting.general_ledger_accounts OWNER TO postgres;

--
-- Name: journal_entries; Type: TABLE; Schema: accounting; Owner: postgres
--

CREATE TABLE accounting.journal_entries (
    journal_id character varying(255) NOT NULL,
    journal_date date NOT NULL,
    description character varying(255) DEFAULT NULL::character varying,
    total_debit numeric(15,2) NOT NULL,
    total_credit numeric(15,2) NOT NULL,
    invoice_id character varying(255) DEFAULT NULL::character varying,
    currency_id character varying(255)
);


ALTER TABLE accounting.journal_entries OWNER TO postgres;

--
-- Name: journal_entry_lines; Type: TABLE; Schema: accounting; Owner: postgres
--

CREATE TABLE accounting.journal_entry_lines (
    entry_line_id character varying(255) NOT NULL,
    gl_account_id character varying(255) DEFAULT NULL::character varying,
    journal_id character varying(255),
    debit_amount numeric(15,2) NOT NULL,
    credit_amount numeric(15,2) NOT NULL,
    description character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE accounting.journal_entry_lines OWNER TO postgres;

--
-- Name: official_receipts; Type: TABLE; Schema: accounting; Owner: postgres
--

CREATE TABLE accounting.official_receipts (
    or_id character varying(255) NOT NULL,
    invoice_id character varying(255),
    customer_id character varying(255),
    or_date date NOT NULL,
    settled_amount numeric(15,2) NOT NULL,
    remaining_amount numeric(15,2),
    payment_method public.payment_method_enum NOT NULL,
    reference_number character varying(100),
    created_by character varying(255)
);


ALTER TABLE accounting.official_receipts OWNER TO postgres;

--
-- Name: assets; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.assets (
    asset_id character varying(255) NOT NULL,
    asset_name character varying(255) NOT NULL,
    purchase_date date DEFAULT now(),
    purchase_price numeric DEFAULT 0 NOT NULL,
    serial_no character varying(225),
    content_id character varying(255)
);


ALTER TABLE admin.assets OWNER TO postgres;

--
-- Name: audit_log; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.audit_log (
    log_id character varying(255) NOT NULL,
    user_id character varying(255),
    action text NOT NULL,
    "timestamp" timestamp without time zone DEFAULT now(),
    ip_address character varying(255)
);


ALTER TABLE admin.audit_log OWNER TO postgres;

--
-- Name: business_partner_master; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.business_partner_master (
    partner_id character varying(255) NOT NULL,
    employee_id character varying(255),
    vendor_code character varying(255),
    customer_id character varying(255),
    partner_name character varying(255) NOT NULL,
    category public.partner_category DEFAULT 'Employee'::public.partner_category,
    contact_info character varying(255)
);


ALTER TABLE admin.business_partner_master OWNER TO postgres;

--
-- Name: currency; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.currency (
    currency_id character varying(255) NOT NULL,
    currency_name character varying(255) NOT NULL,
    exchange_rate numeric(15,6) NOT NULL,
    valid_from date NOT NULL,
    valid_to date
);


ALTER TABLE admin.currency OWNER TO postgres;

--
-- Name: item_master_data; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.item_master_data (
    item_id character varying(255) NOT NULL,
    asset_id character varying(255),
    product_id character varying(255),
    material_id character varying(255),
    item_name character varying(255) NOT NULL,
    item_type public.item_type DEFAULT 'Product'::public.item_type,
    unit_of_measure public.unit_of_measure,
    item_status public.status_enum DEFAULT 'Active'::public.status_enum,
    manage_item_by public.manage_type DEFAULT 'Batches'::public.manage_type,
    preferred_vendor character varying(255),
    purchasing_uom public.unit_of_measure,
    items_per_purchase_unit integer,
    purchase_quantity_per_package integer,
    sales_uom public.unit_of_measure,
    items_per_sale_unit integer,
    sales_quantity_per_package integer
);


ALTER TABLE admin.item_master_data OWNER TO postgres;

--
-- Name: notifications; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.notifications (
    notifications_id character varying(255) NOT NULL,
    module character varying NOT NULL,
    to_user_id character varying NOT NULL,
    message text NOT NULL,
    notifications_status public.notifications_status_enum NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE admin.notifications OWNER TO postgres;

--
-- Name: policies; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.policies (
    policy_id character varying(255) NOT NULL,
    policy_name character varying(255) NOT NULL,
    description text,
    effective_date date DEFAULT now(),
    status public.user_status DEFAULT 'Active'::public.user_status
);


ALTER TABLE admin.policies OWNER TO postgres;

--
-- Name: products; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.products (
    product_id character varying(255) NOT NULL,
    product_name character varying(255) NOT NULL,
    description text NOT NULL,
    selling_price numeric NOT NULL,
    stock_level integer,
    unit_of_measure public.unit_of_measure DEFAULT 'set'::public.unit_of_measure NOT NULL,
    batch_no character varying(255),
    item_status public.status_enum DEFAULT 'Active'::public.status_enum,
    warranty_period integer DEFAULT 12,
    policy_id character varying(255),
    content_id character varying(255)
);


ALTER TABLE admin.products OWNER TO postgres;

--
-- Name: raw_materials; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.raw_materials (
    material_id character varying(255) NOT NULL,
    material_name character varying(255) NOT NULL,
    description text,
    unit_of_measure public.unit_of_measure DEFAULT 'kg'::public.unit_of_measure,
    cost_per_unit numeric,
    vendor_code character varying(255)
);


ALTER TABLE admin.raw_materials OWNER TO postgres;

--
-- Name: roles_permission; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.roles_permission (
    role_id character varying(255) NOT NULL,
    role_name character varying(255),
    description text,
    permissions text,
    access_level public.access_level DEFAULT 'Full Access'::public.access_level
);


ALTER TABLE admin.roles_permission OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.users (
    user_id character varying(255) NOT NULL,
    employee_id character varying(255),
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role_id character varying(255),
    status public.user_status DEFAULT 'Active'::public.user_status,
    type public.user_type DEFAULT 'Employee'::public.user_type,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE admin.users OWNER TO postgres;

--
-- Name: vendor; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.vendor (
    vendor_code character varying(255) NOT NULL,
    application_reference character varying(255),
    vendor_name character varying(255) NOT NULL,
    contact_person character varying(255),
    status public.user_status DEFAULT 'Active'::public.user_status
);


ALTER TABLE admin.vendor OWNER TO postgres;

--
-- Name: warehouse; Type: TABLE; Schema: admin; Owner: postgres
--

CREATE TABLE admin.warehouse (
    warehouse_id character varying(255) NOT NULL,
    warehouse_location character varying(255) NOT NULL,
    stored_materials text
);


ALTER TABLE admin.warehouse OWNER TO postgres;

--
-- Name: billing_receipt; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.billing_receipt (
    billing_receipt_id character varying(255) NOT NULL,
    delivery_receipt_id character varying(255),
    sales_invoice_id character varying(255),
    service_billing_id character varying(255),
    total_receipt numeric(10,2)
);


ALTER TABLE distribution.billing_receipt OWNER TO postgres;

--
-- Name: carrier; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.carrier (
    carrier_id character varying(255) NOT NULL,
    carrier_name character varying(255),
    service_type public.service_type_enum,
    carrier_count integer
);


ALTER TABLE distribution.carrier OWNER TO postgres;

--
-- Name: delivery_order; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.delivery_order (
    del_order_id character varying(255) NOT NULL,
    order_status public.order_status_type,
    content_id character varying(255),
    is_project_based public.project_based_type,
    is_partial_delivery public.yes_no_type,
    service_order_id character varying(255),
    stock_transfer_id character varying(255),
    sales_order_id character varying(255),
    approval_request_id character varying(255),
    del_type public.internal_external_type
);


ALTER TABLE distribution.delivery_order OWNER TO postgres;

--
-- Name: delivery_receipt; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.delivery_receipt (
    delivery_receipt_id character varying(255) NOT NULL,
    delivery_date date,
    received_by character varying(255),
    signature text,
    receipt_status public.receipt_status_type,
    shipment_id character varying(255),
    total_amount numeric(10,2),
    receiving_module character varying(255)
);


ALTER TABLE distribution.delivery_receipt OWNER TO postgres;

--
-- Name: failed_shipment; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.failed_shipment (
    failed_shipment_id character varying(255) NOT NULL,
    failure_date date,
    failure_reason text NOT NULL,
    resolution_status public.resolution_status_type,
    shipment_id character varying(255)
);


ALTER TABLE distribution.failed_shipment OWNER TO postgres;

--
-- Name: goods_issue; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.goods_issue (
    goods_issue_id character varying(255) NOT NULL,
    issue_date date,
    issued_by character varying(255),
    billing_receipt_id character varying(255)
);


ALTER TABLE distribution.goods_issue OWNER TO postgres;

--
-- Name: logistics_approval_request; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.logistics_approval_request (
    approval_request_id character varying(255) NOT NULL,
    request_date date DEFAULT CURRENT_DATE,
    approval_status public.approval_status_type,
    approval_date date,
    approved_by character varying(255),
    del_order_id character varying(255)
);


ALTER TABLE distribution.logistics_approval_request OWNER TO postgres;

--
-- Name: operational_cost; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.operational_cost (
    operational_cost_id character varying(255) NOT NULL,
    additional_cost numeric(10,2),
    total_operational_cost numeric(10,2),
    shipping_cost_id character varying(255),
    packing_cost_id character varying(255)
);


ALTER TABLE distribution.operational_cost OWNER TO postgres;

--
-- Name: packing_cost; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.packing_cost (
    packing_cost_id character varying(255) NOT NULL,
    material_cost numeric(10,2) NOT NULL,
    labor_cost numeric(10,2) NOT NULL,
    total_packing_cost numeric(10,2)
);


ALTER TABLE distribution.packing_cost OWNER TO postgres;

--
-- Name: packing_list; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.packing_list (
    packing_list_id character varying(255) NOT NULL,
    packed_by character varying(255),
    packing_status public.packing_status_type,
    packing_type public.packing_type_enum,
    total_items_packed integer,
    packing_cost_id character varying(255),
    picking_list_id character varying(255),
    packing_date date
);


ALTER TABLE distribution.packing_list OWNER TO postgres;

--
-- Name: picking_list; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.picking_list (
    picking_list_id character varying(255) NOT NULL,
    warehouse_id character varying(255),
    picked_by character varying(255),
    picked_status public.picked_status_type,
    picked_date date,
    approval_request_id character varying(255)
);


ALTER TABLE distribution.picking_list OWNER TO postgres;

--
-- Name: rejection; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.rejection (
    rejection_id character varying(255) NOT NULL,
    rejection_status public.rejection_status_type,
    rejection_reason text NOT NULL,
    rejection_date date,
    delivery_receipt_id character varying(255)
);


ALTER TABLE distribution.rejection OWNER TO postgres;

--
-- Name: rework_order; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.rework_order (
    rework_id character varying(255) NOT NULL,
    assigned_to character varying(255),
    rework_status public.rework_status_type,
    rework_date date,
    expected_completion timestamp without time zone,
    rejection_id character varying(255),
    failed_shipment_id character varying(255),
    rework_types public.rework_types_type
);


ALTER TABLE distribution.rework_order OWNER TO postgres;

--
-- Name: shipment_details; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.shipment_details (
    shipment_id character varying(255) NOT NULL,
    carrier_id character varying(255),
    shipment_date date,
    shipment_status public.shipment_status_type,
    tracking_number character varying(100) NOT NULL,
    estimated_arrival_date timestamp without time zone,
    actual_arrival_date timestamp without time zone,
    packing_list_id character varying(255),
    shipping_cost_id character varying(255)
);


ALTER TABLE distribution.shipment_details OWNER TO postgres;

--
-- Name: shipping_cost; Type: TABLE; Schema: distribution; Owner: postgres
--

CREATE TABLE distribution.shipping_cost (
    shipping_cost_id character varying(255) NOT NULL,
    packing_list_id character varying(255),
    cost_per_kg numeric(10,2),
    cost_per_km numeric(10,2),
    weight_kg numeric(10,2),
    distance_km numeric(10,2),
    total_shipping_cost numeric(10,2)
);


ALTER TABLE distribution.shipping_cost OWNER TO postgres;

--
-- Name: budget_allocation; Type: TABLE; Schema: finance; Owner: postgres
--

CREATE TABLE finance.budget_allocation (
    budget_allocation_id character varying(255) NOT NULL,
    budget_approvals_id character varying(255),
    total_budget numeric(15,2),
    total_spent numeric(15,2),
    total_remaining_budget numeric(15,2),
    allocated_budget numeric(15,2),
    total_allocated_spent numeric(15,2),
    allocated_remaining_budget numeric(15,2),
    status character varying(20),
    start_date date NOT NULL,
    end_date date NOT NULL,
    CONSTRAINT budget_allocation_status_check CHECK (((status)::text = ANY ((ARRAY['tentative'::character varying, 'final'::character varying])::text[])))
);


ALTER TABLE finance.budget_allocation OWNER TO postgres;

--
-- Name: budget_approvals; Type: TABLE; Schema: finance; Owner: postgres
--

CREATE TABLE finance.budget_approvals (
    budget_approvals_id character varying(255) NOT NULL,
    validation_id character varying(255),
    amount_requested numeric(15,2) NOT NULL,
    validated_amount numeric(15,2) NOT NULL,
    validated_by character varying(255) NOT NULL,
    approved_by character varying(255) NOT NULL,
    approval_date date NOT NULL,
    remarks character varying(20),
    approval_status character varying(10),
    CONSTRAINT budget_approvals_approval_status_check CHECK (((approval_status)::text = ANY ((ARRAY['Approved'::character varying, 'Pending'::character varying, 'Rejected'::character varying])::text[]))),
    CONSTRAINT budget_approvals_remarks_check CHECK (((remarks)::text = ANY ((ARRAY['Approved'::character varying, 'Awaiting Approval'::character varying, 'For resubmission'::character varying])::text[])))
);


ALTER TABLE finance.budget_approvals OWNER TO postgres;

--
-- Name: budget_request_form; Type: TABLE; Schema: finance; Owner: postgres
--

CREATE TABLE finance.budget_request_form (
    budget_request_id character varying(255) NOT NULL,
    dept_id character varying(255),
    amount_requested numeric(15,2) NOT NULL,
    requestor_name character varying(100) NOT NULL,
    requested_date date NOT NULL,
    expected_start_usage_period date NOT NULL,
    expected_end_usage_period date NOT NULL,
    urgency_level_request character varying(20) NOT NULL,
    reason_for_request text NOT NULL,
    expense_breakdown_period bytea,
    CONSTRAINT budget_request_form_urgency_level_request_check CHECK (((urgency_level_request)::text = ANY ((ARRAY['Low'::character varying, 'Medium'::character varying, 'High'::character varying])::text[])))
);


ALTER TABLE finance.budget_request_form OWNER TO postgres;

--
-- Name: budget_returns_form; Type: TABLE; Schema: finance; Owner: postgres
--

CREATE TABLE finance.budget_returns_form (
    budget_return_id character varying(255) NOT NULL,
    dept_id character varying(255),
    budget_request_id character varying(255),
    returner_name character varying(255) NOT NULL,
    return_date date NOT NULL,
    returned_amount numeric(15,2) NOT NULL,
    total_amount_requested numeric(15,2) NOT NULL,
    reason_returned character varying(50) NOT NULL,
    expense_history_breakdown bytea,
    CONSTRAINT budget_returns_form_reason_returned_check CHECK (((reason_returned)::text = ANY ((ARRAY['Project Cancelled'::character varying, 'Unused Funds'::character varying, 'Overestimation'::character varying])::text[])))
);


ALTER TABLE finance.budget_returns_form OWNER TO postgres;

--
-- Name: budget_submission; Type: TABLE; Schema: finance; Owner: postgres
--

CREATE TABLE finance.budget_submission (
    budget_submission_id character varying(255) NOT NULL,
    dept_id character varying(255),
    submitter_name character varying(255) NOT NULL,
    date_submitted date NOT NULL,
    proposed_total_budget numeric(12,2) NOT NULL,
    start_usage_period date NOT NULL,
    end_usage_period date NOT NULL,
    expense_breakdown bytea
);


ALTER TABLE finance.budget_submission OWNER TO postgres;

--
-- Name: budget_validations; Type: TABLE; Schema: finance; Owner: postgres
--

CREATE TABLE finance.budget_validations (
    validation_id character varying(255) NOT NULL,
    budget_submission_id character varying(255),
    budget_request_id character varying(255),
    budget_return_id character varying(255),
    validation_date date,
    validated_by character varying(255),
    validation_status character varying(10),
    remarks character varying(20),
    comments character varying(100),
    amount_requested numeric(15,2) NOT NULL,
    final_approved_amount numeric(12,2),
    CONSTRAINT budget_validations_comments_check CHECK (((comments)::text = ANY ((ARRAY['Exact Amount Returned'::character varying, 'Budget Mismatched'::character varying, 'Overreturned'::character varying, 'Underreturned'::character varying, 'Revalidation Needed'::character varying, 'Document Issue'::character varying])::text[]))),
    CONSTRAINT budget_validations_remarks_check CHECK (((remarks)::text = ANY ((ARRAY['Approved'::character varying, 'Awaiting Validation'::character varying, 'For resubmission'::character varying])::text[]))),
    CONSTRAINT budget_validations_validation_status_check CHECK (((validation_status)::text = ANY ((ARRAY['Validated'::character varying, 'Pending'::character varying, 'To review'::character varying])::text[])))
);


ALTER TABLE finance.budget_validations OWNER TO postgres;

--
-- Name: attendance_tracking; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.attendance_tracking (
    attendance_id character varying(255) NOT NULL,
    employee_id character varying(255),
    date date,
    time_in timestamp without time zone,
    time_out timestamp without time zone,
    status character varying(20),
    late_hours numeric(4,2) DEFAULT 0,
    undertime_hours numeric(4,2) DEFAULT 0,
    is_holiday boolean DEFAULT false,
    holiday_type character varying(20),
    work_hours numeric(5,2) GENERATED ALWAYS AS (
CASE
    WHEN (time_out IS NULL) THEN (0)::numeric
    ELSE ((EXTRACT(epoch FROM (time_out - time_in)) / (3600)::numeric) - late_hours)
END) STORED,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_holiday_type CHECK (((holiday_type)::text = ANY ((ARRAY[NULL::character varying, 'Regular'::character varying, 'Special'::character varying])::text[]))),
    CONSTRAINT chk_status CHECK (((status)::text = ANY ((ARRAY['Present'::character varying, 'Absent'::character varying, 'Late'::character varying, 'Half-Day'::character varying])::text[])))
);


ALTER TABLE human_resources.attendance_tracking OWNER TO postgres;

--
-- Name: calendar_dates; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.calendar_dates (
    date date NOT NULL,
    is_workday boolean NOT NULL,
    is_holiday boolean DEFAULT false NOT NULL,
    is_special boolean DEFAULT false NOT NULL,
    holiday_name character varying(100)
);


ALTER TABLE human_resources.calendar_dates OWNER TO postgres;

--
-- Name: candidates; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.candidates (
    candidate_id character varying(255) NOT NULL,
    job_id character varying(255),
    first_name character varying(50),
    last_name character varying(50),
    email character varying(100),
    phone character varying(20),
    resume_path text,
    application_status character varying(50) DEFAULT 'Applied'::character varying,
    documents jsonb,
    interview_details jsonb,
    offer_details jsonb,
    contract_details jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_application_status CHECK (((application_status)::text = ANY ((ARRAY['Applied'::character varying, 'Document Screening'::character varying, 'Interview Scheduled'::character varying, 'Interview Completed'::character varying, 'Offer Extended'::character varying, 'Contract Signed'::character varying, 'Hired'::character varying, 'Rejected'::character varying])::text[])))
);


ALTER TABLE human_resources.candidates OWNER TO postgres;

--
-- Name: department_superiors; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.department_superiors (
    dept_id character varying(255) NOT NULL,
    position_id character varying(255) NOT NULL,
    hierarchy_level integer,
    CONSTRAINT chk_hierarchy_level CHECK ((hierarchy_level > 0))
);


ALTER TABLE human_resources.department_superiors OWNER TO postgres;

--
-- Name: departments; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.departments (
    dept_id character varying(255) NOT NULL,
    dept_name character varying(100),
    is_archived boolean DEFAULT false
);


ALTER TABLE human_resources.departments OWNER TO postgres;

--
-- Name: employee_leave_balances; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee_leave_balances (
    balance_id character varying(255) NOT NULL,
    employee_id character varying(255),
    year integer DEFAULT EXTRACT(year FROM CURRENT_DATE),
    sick_leave_remaining integer DEFAULT 15,
    vacation_leave_remaining integer DEFAULT 15,
    maternity_leave_remaining integer DEFAULT 105,
    paternity_leave_remaining integer DEFAULT 7,
    solo_parent_leave_remaining integer DEFAULT 7,
    unpaid_leave_taken integer DEFAULT 0,
    CONSTRAINT chk_positive_balances CHECK (((sick_leave_remaining >= 0) AND (vacation_leave_remaining >= 0) AND (maternity_leave_remaining >= 0) AND (paternity_leave_remaining >= 0) AND (solo_parent_leave_remaining >= 0) AND (unpaid_leave_taken >= 0)))
);


ALTER TABLE human_resources.employee_leave_balances OWNER TO postgres;

--
-- Name: employee_performance; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee_performance (
    performance_id character varying(255) NOT NULL,
    employee_id character varying(255),
    immediate_superior_id character varying(255),
    rating integer,
    bonus_amount numeric(12,2),
    bonus_payment_month integer,
    review_date date,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_bonus_payment_month CHECK (((bonus_payment_month >= 1) AND (bonus_payment_month <= 12))),
    CONSTRAINT chk_rating CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE human_resources.employee_performance OWNER TO postgres;

--
-- Name: employee_salary; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employee_salary (
    salary_id character varying(255) NOT NULL,
    employee_id character varying(255),
    base_salary numeric(12,2),
    daily_rate numeric(12,2),
    effective_date date
);


ALTER TABLE human_resources.employee_salary OWNER TO postgres;

--
-- Name: employees; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.employees (
    employee_id character varying(255) NOT NULL,
    user_id character varying(255),
    dept_id character varying(255),
    position_id character varying(255),
    first_name character varying(50),
    last_name character varying(50),
    phone character varying(20),
    employment_type character varying(20),
    status character varying(20) DEFAULT 'Active'::character varying,
    reports_to character varying(255),
    is_supervisor boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_employment_type CHECK (((employment_type)::text = ANY ((ARRAY['Regular'::character varying, 'Contractual'::character varying, 'Seasonal'::character varying])::text[]))),
    CONSTRAINT chk_status CHECK (((status)::text = ANY ((ARRAY['Active'::character varying, 'Inactive'::character varying, 'Resigned'::character varying, 'On Notice'::character varying])::text[])))
);


ALTER TABLE human_resources.employees OWNER TO postgres;

--
-- Name: job_posting; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.job_posting (
    job_id character varying(255) NOT NULL,
    dept_id character varying(255),
    position_id character varying(255),
    position_title character varying(100),
    description text,
    requirements text,
    employment_type character varying(20),
    base_salary numeric(10,2),
    daily_rate numeric(10,2),
    duration_days smallint,
    finance_approval_id character varying(255),
    finance_approval_status character varying(20) DEFAULT 'Pending'::character varying,
    posting_status character varying(20) DEFAULT 'Draft'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_compensation_fields CHECK (((((employment_type)::text = 'Regular'::text) AND (base_salary IS NOT NULL) AND (daily_rate IS NULL)) OR (((employment_type)::text = ANY ((ARRAY['Contractual'::character varying, 'Seasonal'::character varying])::text[])) AND (daily_rate IS NOT NULL) AND (base_salary IS NULL)))),
    CONSTRAINT chk_duration_days CHECK (((((employment_type)::text = 'Contractual'::text) AND ((duration_days >= 30) AND (duration_days <= 180))) OR (((employment_type)::text = 'Seasonal'::text) AND ((duration_days >= 1) AND (duration_days <= 29))) OR (((employment_type)::text = 'Regular'::text) AND (duration_days IS NULL)))),
    CONSTRAINT chk_employment_type CHECK (((employment_type)::text = ANY ((ARRAY['Regular'::character varying, 'Contractual'::character varying, 'Seasonal'::character varying])::text[]))),
    CONSTRAINT chk_finance_approval_status CHECK (((finance_approval_status)::text = ANY ((ARRAY['Pending'::character varying, 'Approved'::character varying, 'Rejected'::character varying])::text[]))),
    CONSTRAINT chk_posting_status CHECK (((posting_status)::text = ANY ((ARRAY['Draft'::character varying, 'Pending Finance Approval'::character varying, 'Open'::character varying, 'Closed'::character varying, 'Filled'::character varying])::text[])))
);


ALTER TABLE human_resources.job_posting OWNER TO postgres;

--
-- Name: leave_requests; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.leave_requests (
    leave_id character varying(255) NOT NULL,
    employee_id character varying(255),
    dept_id character varying(255),
    immediate_superior_id character varying(255),
    management_approval_id character varying(255),
    leave_type character varying(20),
    start_date date,
    end_date date,
    total_days integer,
    is_paid boolean DEFAULT true,
    status character varying(50) DEFAULT 'Pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_leave_types CHECK (((leave_type)::text = ANY ((ARRAY['Sick'::character varying, 'Vacation'::character varying, 'Personal'::character varying, 'Maternity'::character varying, 'Paternity'::character varying, 'Solo Parent'::character varying, 'Unpaid'::character varying])::text[]))),
    CONSTRAINT chk_status_values CHECK (((status)::text = ANY ((ARRAY['Pending'::character varying, 'Approved by Superior'::character varying, 'Rejected by Superior'::character varying, 'Approved by Management'::character varying, 'Rejected by Management'::character varying, 'Recorded in HRIS'::character varying])::text[]))),
    CONSTRAINT chk_valid_dates CHECK ((end_date >= start_date))
);


ALTER TABLE human_resources.leave_requests OWNER TO postgres;

--
-- Name: payroll; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.payroll (
    payroll_id character varying(255) NOT NULL,
    employee_id character varying(255),
    pay_period_start date,
    pay_period_end date,
    employment_type character varying(20) NOT NULL,
    base_salary numeric(12,2),
    overtime_hours numeric(5,2) DEFAULT 0,
    overtime_pay numeric(12,2) DEFAULT 0,
    holiday_pay numeric(12,2) DEFAULT 0,
    bonus_pay numeric(12,2) DEFAULT 0,
    thirteenth_month_pay numeric(12,2) DEFAULT 0,
    gross_pay numeric(12,2) GENERATED ALWAYS AS (((((base_salary + overtime_pay) + holiday_pay) + bonus_pay) + thirteenth_month_pay)) STORED,
    sss_contribution numeric(12,2) DEFAULT 0,
    philhealth_contribution numeric(12,2) DEFAULT 0,
    pagibig_contribution numeric(12,2) DEFAULT 0,
    tax numeric(12,2) DEFAULT 0,
    late_deduction numeric(12,2) DEFAULT 0,
    absent_deduction numeric(12,2) DEFAULT 0,
    undertime_deduction numeric(12,2) DEFAULT 0,
    total_deductions numeric(12,2) GENERATED ALWAYS AS (((((((sss_contribution + philhealth_contribution) + pagibig_contribution) + tax) + late_deduction) + absent_deduction) + undertime_deduction)) STORED,
    net_pay numeric(12,2) GENERATED ALWAYS AS ((((((base_salary + overtime_pay) + holiday_pay) + bonus_pay) + thirteenth_month_pay) - ((((((sss_contribution + philhealth_contribution) + pagibig_contribution) + tax) + late_deduction) + absent_deduction) + undertime_deduction))) STORED,
    status character varying(20) DEFAULT 'Draft'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_pay_period CHECK ((pay_period_end > pay_period_start)),
    CONSTRAINT chk_regular_employee_benefits CHECK ((((employment_type)::text = 'Regular'::text) OR (thirteenth_month_pay = (0)::numeric))),
    CONSTRAINT chk_status CHECK (((status)::text = ANY ((ARRAY['Draft'::character varying, 'Processing'::character varying, 'Completed'::character varying, 'Cancelled'::character varying])::text[])))
);


ALTER TABLE human_resources.payroll OWNER TO postgres;

--
-- Name: positions; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.positions (
    position_id character varying(255) NOT NULL,
    position_title character varying(100),
    salary_grade character varying(20),
    min_salary numeric(10,2),
    max_salary numeric(10,2),
    employment_type character varying(20),
    typical_duration_days smallint,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_duration_days CHECK (((((employment_type)::text = 'Contractual'::text) AND ((typical_duration_days >= 30) AND (typical_duration_days <= 180))) OR (((employment_type)::text = 'Seasonal'::text) AND ((typical_duration_days >= 1) AND (typical_duration_days <= 29))) OR (((employment_type)::text = 'Regular'::text) AND (typical_duration_days IS NULL)))),
    CONSTRAINT chk_employment_types CHECK (((employment_type)::text = ANY ((ARRAY['Regular'::character varying, 'Contractual'::character varying, 'Seasonal'::character varying])::text[]))),
    CONSTRAINT chk_salary_ranges CHECK (((((employment_type)::text = 'Regular'::text) AND (min_salary >= (0)::numeric) AND (max_salary >= min_salary)) OR (((employment_type)::text = ANY ((ARRAY['Contractual'::character varying, 'Seasonal'::character varying])::text[])) AND ((min_salary >= (500)::numeric) AND (min_salary <= (10000)::numeric)) AND (max_salary >= min_salary))))
);


ALTER TABLE human_resources.positions OWNER TO postgres;

--
-- Name: resignations; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.resignations (
    resignation_id character varying(255) NOT NULL,
    employee_id character varying(255) NOT NULL,
    submission_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    notice_period_days integer,
    hr_approver_id character varying(255),
    approval_status character varying(20) DEFAULT 'Pending'::character varying,
    clearance_status character varying(20) DEFAULT 'Pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE human_resources.resignations OWNER TO postgres;

--
-- Name: workforce_allocation; Type: TABLE; Schema: human_resources; Owner: postgres
--

CREATE TABLE human_resources.workforce_allocation (
    allocation_id character varying(255) NOT NULL,
    request_id character varying(255),
    requesting_dept_id character varying(255),
    required_skills text,
    task_description text,
    employee_id character varying(255),
    current_dept_id character varying(255),
    hr_approver_id character varying(255),
    approval_status character varying(20) DEFAULT 'Pending'::character varying,
    status character varying(20) DEFAULT 'Draft'::character varying,
    start_date date,
    end_date date,
    rejection_reason text,
    submitted_at timestamp without time zone,
    approved_at timestamp without time zone,
    CONSTRAINT chk_approval_status CHECK (((approval_status)::text = ANY ((ARRAY['Pending'::character varying, 'Approved'::character varying, 'Rejected'::character varying, 'Under Review'::character varying])::text[]))),
    CONSTRAINT chk_status CHECK (((status)::text = ANY ((ARRAY['Draft'::character varying, 'Submitted'::character varying, 'Active'::character varying, 'Completed'::character varying, 'Canceled'::character varying])::text[]))),
    CONSTRAINT employee_assignment_logic CHECK (((((approval_status)::text = 'Approved'::text) AND (employee_id IS NOT NULL)) OR ((approval_status)::text <> 'Approved'::text))),
    CONSTRAINT valid_allocation_period CHECK ((end_date >= start_date))
);


ALTER TABLE human_resources.workforce_allocation OWNER TO postgres;

--
-- Name: deprecation_report; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.deprecation_report (
    deprecation_report_id character varying(255) NOT NULL,
    inventory_item_id character varying(255),
    reported_date timestamp without time zone NOT NULL,
    deprecation_status public.inventory_status_enum NOT NULL
);


ALTER TABLE inventory.deprecation_report OWNER TO postgres;

--
-- Name: expiry_report; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.expiry_report (
    expiry_report_id character varying(255) NOT NULL,
    inventory_item_id character varying(255),
    reported_date timestamp without time zone NOT NULL,
    expiry_report_status public.inventory_status_enum NOT NULL
);


ALTER TABLE inventory.expiry_report OWNER TO postgres;

--
-- Name: inventory_adjustments; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.inventory_adjustments (
    adjustment_id character varying(255) NOT NULL,
    item_id character varying(255),
    adjustment_type public.adjustment_type_enum NOT NULL,
    quantity integer NOT NULL,
    adjustment_date timestamp without time zone NOT NULL,
    employee_id character varying(255)
);


ALTER TABLE inventory.inventory_adjustments OWNER TO postgres;

--
-- Name: inventory_cyclic_counts; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.inventory_cyclic_counts (
    inventory_count_id character varying(255) NOT NULL,
    inventory_item_id character varying(255),
    item_onhand integer NOT NULL,
    item_actually_counted integer NOT NULL,
    difference_in_qty integer NOT NULL,
    employee_id character varying(255),
    status public.inventory_status NOT NULL,
    remarks text,
    time_period public.inventory_time_period NOT NULL,
    warehouse_id character varying(255)
);


ALTER TABLE inventory.inventory_cyclic_counts OWNER TO postgres;

--
-- Name: inventory_item; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.inventory_item (
    inventory_item_id character varying(255) NOT NULL,
    serial_id character varying(255),
    productdocu_id character varying(255),
    material_id character varying(255),
    asset_id character varying(255),
    item_type public.item_type NOT NULL,
    current_quantity integer NOT NULL,
    warehouse_id character varying(255),
    expiry timestamp without time zone,
    shelf_life public.shelf_life_enum,
    last_update timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    date_created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE inventory.inventory_item OWNER TO postgres;

--
-- Name: inventory_item_threshold; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.inventory_item_threshold (
    inventory_item_threshold_id character varying(255) NOT NULL,
    item_id character varying(255),
    minimum_threshold integer NOT NULL,
    maximum_threshold integer NOT NULL
);


ALTER TABLE inventory.inventory_item_threshold OWNER TO postgres;

--
-- Name: warehouse_movement; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.warehouse_movement (
    movement_id character varying(255) NOT NULL,
    docu_creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    movement_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    movement_status public.inventory_status NOT NULL,
    destination character varying(255),
    source character varying(255),
    reference_id_purchase_order character varying(255),
    reference_id_order character varying(255),
    comments text
);


ALTER TABLE inventory.warehouse_movement OWNER TO postgres;

--
-- Name: warehouse_movement_items; Type: TABLE; Schema: inventory; Owner: postgres
--

CREATE TABLE inventory.warehouse_movement_items (
    movement_id character varying(255) NOT NULL,
    inventory_item_id character varying(255) NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE inventory.warehouse_movement_items OWNER TO postgres;

--
-- Name: management_approvals; Type: TABLE; Schema: management; Owner: postgres
--

CREATE TABLE management.management_approvals (
    approval_id character varying(255) NOT NULL,
    request_id_all character varying(255),
    external_id character varying(255),
    decision_date date,
    issue_date date,
    checked_by character varying(255),
    checked_date date DEFAULT CURRENT_DATE,
    status public.management_approval_status NOT NULL,
    due_date date,
    remarks text
);


ALTER TABLE management.management_approvals OWNER TO postgres;

--
-- Name: bill_of_materials; Type: TABLE; Schema: mrp; Owner: postgres
--

CREATE TABLE mrp.bill_of_materials (
    bom_id character varying(255) NOT NULL,
    project_id character varying(255),
    product_mats_id character varying(255),
    overall_quantity_of_material integer,
    cost_per_raw_material numeric(10,2) NOT NULL,
    total_cost_of_raw_materials numeric(10,2) NOT NULL,
    production_order_detail_id character varying(255),
    labor_cost_id character varying(255),
    total_cost character varying(255)
);


ALTER TABLE mrp.bill_of_materials OWNER TO postgres;

--
-- Name: labor_cost; Type: TABLE; Schema: mrp; Owner: postgres
--

CREATE TABLE mrp.labor_cost (
    labor_cost_id character varying(255) NOT NULL,
    labor_id character varying(255),
    salary_id character varying(255)
);


ALTER TABLE mrp.labor_cost OWNER TO postgres;

--
-- Name: non_project_order_pricing; Type: TABLE; Schema: mrp; Owner: postgres
--

CREATE TABLE mrp.non_project_order_pricing (
    non_project_costing_id character varying(255) NOT NULL,
    order_id character varying(255),
    final_price numeric(10,2) NOT NULL
);


ALTER TABLE mrp.non_project_order_pricing OWNER TO postgres;

--
-- Name: principal_items; Type: TABLE; Schema: mrp; Owner: postgres
--

CREATE TABLE mrp.principal_items (
    principal_item_id character varying(255) NOT NULL,
    service_order_item_id character varying(255),
    item_id character varying(255),
    mark_up_price numeric(10,2) NOT NULL
);


ALTER TABLE mrp.principal_items OWNER TO postgres;

--
-- Name: product_mats; Type: TABLE; Schema: mrp; Owner: postgres
--

CREATE TABLE mrp.product_mats (
    product_mats_id character varying(255) NOT NULL,
    product_id character varying(255),
    material_id character varying(255),
    quantity_required numeric(10,2) NOT NULL,
    cost_of_used_materials numeric(10,2) NOT NULL
);


ALTER TABLE mrp.product_mats OWNER TO postgres;

--
-- Name: ar_credit_memo_seq; Type: SEQUENCE; Schema: operations; Owner: postgres
--

CREATE SEQUENCE operations.ar_credit_memo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE operations.ar_credit_memo_seq OWNER TO postgres;

--
-- Name: asset_serial_seq; Type: SEQUENCE; Schema: operations; Owner: postgres
--

CREATE SEQUENCE operations.asset_serial_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE operations.asset_serial_seq OWNER TO postgres;

--
-- Name: batch_number_seq; Type: SEQUENCE; Schema: operations; Owner: postgres
--

CREATE SEQUENCE operations.batch_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE operations.batch_number_seq OWNER TO postgres;

--
-- Name: document_header; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.document_header (
    document_id character varying(255) NOT NULL,
    document_type public.document_type_enum NOT NULL,
    vendor_code character varying(255),
    document_no integer NOT NULL,
    transaction_id character varying(255) NOT NULL,
    content_id character varying(255),
    invoice_id character varying(255),
    ar_credit_memo character varying(255),
    status public.operations_status_enum NOT NULL,
    posting_date date NOT NULL,
    delivery_date date,
    document_date date NOT NULL,
    buyer character varying(255) NOT NULL,
    employee_id character varying(255),
    initial_amount numeric(18,2) NOT NULL,
    discount_rate numeric(5,2),
    discount_amount numeric(18,2),
    freight numeric(18,2) NOT NULL,
    tax_rate numeric(5,2) NOT NULL,
    tax_amount numeric(18,2) NOT NULL,
    transaction_cost numeric(18,2)
);


ALTER TABLE operations.document_header OWNER TO postgres;

--
-- Name: document_items; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.document_items (
    content_id character varying(255) NOT NULL,
    asset_id character varying(255),
    document_id character varying(255),
    material_id character varying(255),
    serial_id character varying(255),
    productdocu_id character varying(255),
    external_id character varying(255),
    delivery_request_id character varying(255),
    request_date date,
    quantity integer DEFAULT 0 NOT NULL,
    total numeric(18,2),
    batch_no character varying(100),
    warehouse_id character varying(255),
    cost numeric(18,2),
    delivery_type public.request_type,
    receiving_module public.receiving_module_enum,
    status public.approval_status_type DEFAULT 'Pending'::public.approval_status_type
);


ALTER TABLE operations.document_items OWNER TO postgres;

--
-- Name: external_module; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.external_module (
    external_id character varying(255) NOT NULL,
    content_id character varying(255),
    purchase_id character varying(255),
    request_id character varying(255),
    approval_id character varying(255),
    goods_issue_id character varying(255),
    approval_request_id character varying(255),
    billing_receipt_id character varying(255),
    delivery_receipt_id character varying(255),
    project_resources_id character varying(255),
    project_tracking_id character varying(255),
    project_request_id character varying(255),
    production_order_detail_id character varying(255),
    rework_id character varying(255),
    deprecation_report_id character varying(255),
    rework_quantity integer DEFAULT 0,
    reason_rework text
);


ALTER TABLE operations.external_module OWNER TO postgres;

--
-- Name: product_document_items; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.product_document_items (
    productdocu_id character varying(255) NOT NULL,
    product_id character varying(255),
    manuf_date date NOT NULL,
    expiry_date date NOT NULL,
    content_id character varying(255)
);


ALTER TABLE operations.product_document_items OWNER TO postgres;

--
-- Name: serial_tracking; Type: TABLE; Schema: operations; Owner: postgres
--

CREATE TABLE operations.serial_tracking (
    serial_id character varying(255) NOT NULL,
    document_id character varying(255),
    serial_no character varying(50)
);


ALTER TABLE operations.serial_tracking OWNER TO postgres;

--
-- Name: equipment; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.equipment (
    equipment_id character varying(255) NOT NULL,
    equipment_name character varying(255) NOT NULL,
    description text,
    availability_status public.availability_status DEFAULT 'Available'::public.availability_status,
    last_maintenance_date date DEFAULT now(),
    equipment_cost numeric(10,2) NOT NULL
);


ALTER TABLE production.equipment OWNER TO postgres;

--
-- Name: labor; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.labor (
    labor_id character varying(255) NOT NULL,
    production_order_id character varying(255),
    employee_id character varying(255),
    date_worked timestamp without time zone DEFAULT now(),
    days_worked integer NOT NULL
);


ALTER TABLE production.labor OWNER TO postgres;

--
-- Name: production_orders_details; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.production_orders_details (
    production_order_detail_id character varying(255) NOT NULL,
    production_order_id character varying(255),
    actual_quantity integer NOT NULL,
    cost_of_production numeric(10,2) NOT NULL,
    miscellaneous_costs numeric(10,2) NOT NULL,
    equipment_id character varying(255),
    rework_required boolean NOT NULL,
    rework_notes text,
    external_id character varying(255)
);


ALTER TABLE production.production_orders_details OWNER TO postgres;

--
-- Name: production_orders_header; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.production_orders_header (
    production_order_id character varying(255) NOT NULL,
    task_id character varying(255),
    bom_id character varying(255),
    start_date timestamp without time zone DEFAULT now(),
    end_date timestamp without time zone DEFAULT now(),
    status public.prod_status DEFAULT 'Pending'::public.prod_status,
    target_quantity integer NOT NULL,
    notes text
);


ALTER TABLE production.production_orders_header OWNER TO postgres;

--
-- Name: project_equipment; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.project_equipment (
    project_equipment_id character varying(255) NOT NULL,
    equipment_id character varying(255),
    product_id character varying(255)
);


ALTER TABLE production.project_equipment OWNER TO postgres;

--
-- Name: rework_cost; Type: TABLE; Schema: production; Owner: postgres
--

CREATE TABLE production.rework_cost (
    rework_cost_id character varying(255) NOT NULL,
    production_order_id character varying(255),
    additional_cost numeric(10,2) NOT NULL,
    additional_misc numeric(10,2) NOT NULL,
    total_rework_cost numeric(10,2) NOT NULL
);


ALTER TABLE production.rework_cost OWNER TO postgres;

--
-- Name: external_project_cost_management; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_cost_management (
    project_resources_id character varying(255) NOT NULL,
    project_id character varying(255),
    bom_id character varying(255),
    project_budget_approval public.project_budget_approval NOT NULL
);


ALTER TABLE project_management.external_project_cost_management OWNER TO postgres;

--
-- Name: external_project_details; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_details (
    project_id character varying(255) NOT NULL,
    ext_project_request_id character varying(255),
    project_status public.project_status NOT NULL
);


ALTER TABLE project_management.external_project_details OWNER TO postgres;

--
-- Name: external_project_equipments; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_equipments (
    project_equipment_list_id character varying(255) NOT NULL,
    project_id character varying(255),
    project_equipment_id character varying(255)
);


ALTER TABLE project_management.external_project_equipments OWNER TO postgres;

--
-- Name: external_project_labor; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_labor (
    project_labor_id character varying(255) NOT NULL,
    project_id character varying(255),
    job_role_needed character varying(255),
    employee_id character varying(255)
);


ALTER TABLE project_management.external_project_labor OWNER TO postgres;

--
-- Name: external_project_request; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_request (
    ext_project_request_id character varying(255) NOT NULL,
    ext_project_name character varying(50),
    ext_project_description text,
    approval_id character varying(255),
    item_id character varying(255)
);


ALTER TABLE project_management.external_project_request OWNER TO postgres;

--
-- Name: external_project_task_list; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_task_list (
    task_id character varying(255) NOT NULL,
    project_id character varying(255),
    task_description text,
    task_status public.task_status NOT NULL,
    task_deadline date NOT NULL,
    project_labor_id character varying(255)
);


ALTER TABLE project_management.external_project_task_list OWNER TO postgres;

--
-- Name: external_project_tracking; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_tracking (
    project_tracking_id character varying(255) NOT NULL,
    project_id character varying(255),
    project_milestone public.project_milestone NOT NULL,
    start_date date NOT NULL,
    estimated_end_date date NOT NULL,
    project_warranty_id character varying(255),
    project_issue text
);


ALTER TABLE project_management.external_project_tracking OWNER TO postgres;

--
-- Name: external_project_warranty; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.external_project_warranty (
    project_warranty_id character varying(255) NOT NULL,
    project_id character varying(255),
    warranty_coverage_yr integer NOT NULL,
    warranty_start_date date NOT NULL,
    warranty_end_date date NOT NULL,
    CONSTRAINT external_project_warranty_check CHECK ((warranty_end_date > warranty_start_date))
);


ALTER TABLE project_management.external_project_warranty OWNER TO postgres;

--
-- Name: internal_project_cost_management; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.internal_project_cost_management (
    intrnl_project_resources_id character varying(255) NOT NULL,
    intrnl_project_id character varying(255),
    bom_id character varying(255),
    project_budget_approval public.project_budget_approval NOT NULL
);


ALTER TABLE project_management.internal_project_cost_management OWNER TO postgres;

--
-- Name: internal_project_details; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.internal_project_details (
    intrnl_project_id character varying(255) NOT NULL,
    project_request_id character varying(255),
    intrnl_project_status public.intrnl_project_status NOT NULL,
    approval_id character varying(255)
);


ALTER TABLE project_management.internal_project_details OWNER TO postgres;

--
-- Name: internal_project_labor; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.internal_project_labor (
    intrnl_project_labor_id character varying(255) NOT NULL,
    intrnl_project_id character varying(255),
    intrnl_job_role_needed character varying(255),
    employee_id character varying(255)
);


ALTER TABLE project_management.internal_project_labor OWNER TO postgres;

--
-- Name: internal_project_request; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.internal_project_request (
    project_request_id character varying(255) NOT NULL,
    project_name character varying(50) NOT NULL,
    project_description text,
    request_date date NOT NULL,
    target_starting_date date NOT NULL,
    employee_id character varying(255),
    dept_id character varying(255),
    project_budget_request numeric(10,2),
    project_budget_description text
);


ALTER TABLE project_management.internal_project_request OWNER TO postgres;

--
-- Name: internal_project_task_list; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.internal_project_task_list (
    intrnl_task_id character varying(255) NOT NULL,
    intrnl_project_id character varying(255),
    intrnl_task_description text,
    intrnl_task_status public.intrnl_task_status NOT NULL,
    intrnl_task_deadline date NOT NULL,
    intrnl_project_labor_id character varying(255)
);


ALTER TABLE project_management.internal_project_task_list OWNER TO postgres;

--
-- Name: internal_project_tracking; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.internal_project_tracking (
    intrnl_project_tracking_id character varying(255) NOT NULL,
    intrnl_project_id character varying(255),
    intrnl_start_date date NOT NULL,
    intrnl_estimated_end_date date NOT NULL,
    intrnl_project_issue text
);


ALTER TABLE project_management.internal_project_tracking OWNER TO postgres;

--
-- Name: report_monitoring; Type: TABLE; Schema: project_management; Owner: postgres
--

CREATE TABLE project_management.report_monitoring (
    report_monitoring_id character varying(255) NOT NULL,
    project_id character varying(255),
    intrnl_project_id character varying(255),
    report_type public.report_type NOT NULL,
    report_title character varying(255),
    received_from public.ext_modules,
    date_created date NOT NULL,
    assigned_to public.ext_modules,
    description text
);


ALTER TABLE project_management.report_monitoring OWNER TO postgres;

--
-- Name: batch_inspection; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.batch_inspection (
    inspection_id character varying(255) NOT NULL,
    shipment_id character varying(255),
    employee_id character varying(255),
    inspection_date date,
    inspection_result public.inspection_result,
    remarks character varying(255)
);


ALTER TABLE purchasing.batch_inspection OWNER TO postgres;

--
-- Name: credit_memo; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.credit_memo (
    credit_memo_id character varying(255) NOT NULL,
    invoice_id character varying(255),
    inspection_id character varying(255),
    status public.purchase_status,
    document_no integer,
    document_date date,
    delivery_date date,
    due_date date,
    total_credit numeric(10,2),
    credit_balance numeric(10,2),
    dpm_rate numeric(5,2),
    dpm_amount numeric(10,2),
    applied_amount numeric(10,2),
    balance_due numeric(10,2)
);


ALTER TABLE purchasing.credit_memo OWNER TO postgres;

--
-- Name: purchase_invoice; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_invoice (
    invoice_id character varying(255) NOT NULL,
    content_id character varying(255),
    status public.purchase_status,
    document_no integer,
    document_date date,
    due_date date,
    total_credit numeric(10,2),
    credit_balance numeric(10,2),
    dpm_rate numeric(5,2),
    dpm_amount numeric(10,2),
    applied_amount numeric(10,2),
    balance_due numeric(10,2)
);


ALTER TABLE purchasing.purchase_invoice OWNER TO postgres;

--
-- Name: purchase_order; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_order (
    purchase_id character varying(255) NOT NULL,
    quotation_id character varying(255),
    order_date date,
    delivery_date date,
    document_date date,
    status public.purchase_status
);


ALTER TABLE purchasing.purchase_order OWNER TO postgres;

--
-- Name: purchase_quotation; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_quotation (
    quotation_id character varying(255) NOT NULL,
    request_id character varying(255),
    vendor_code character varying(255),
    status public.purchase_status,
    document_no integer,
    valid_date date,
    document_date date,
    required_date date,
    remarks text,
    delivery_loc character varying(255),
    downpayment_request integer DEFAULT 0,
    total_before_discount numeric(10,2),
    discount_percent numeric(5,2),
    freight numeric(10,2),
    tax numeric(10,2),
    total_payment numeric(10,2)
);


ALTER TABLE purchasing.purchase_quotation OWNER TO postgres;

--
-- Name: purchase_requests; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.purchase_requests (
    request_id character varying(255) NOT NULL,
    employee_id character varying(255),
    approval_id character varying(255),
    valid_date date,
    document_date date,
    required_date date
);


ALTER TABLE purchasing.purchase_requests OWNER TO postgres;

--
-- Name: quotation_contents; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.quotation_contents (
    quotation_content_id character varying(255) NOT NULL,
    request_id character varying(255),
    material_id character varying(255),
    asset_id character varying(255),
    purchase_quantity integer,
    unit_price numeric(10,2),
    discount numeric(10,2),
    tax_code character varying(50),
    total numeric(10,2)
);


ALTER TABLE purchasing.quotation_contents OWNER TO postgres;

--
-- Name: received_shipments; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.received_shipments (
    shipment_id character varying(255) NOT NULL,
    purchase_id character varying(255),
    delivery_date date
);


ALTER TABLE purchasing.received_shipments OWNER TO postgres;

--
-- Name: vendor_application; Type: TABLE; Schema: purchasing; Owner: postgres
--

CREATE TABLE purchasing.vendor_application (
    application_reference character varying(255) NOT NULL,
    status public.vendor_application_status,
    company_name character varying,
    tax_number integer,
    contact_person character varying,
    title character varying,
    vendor_address character varying,
    phone bigint,
    fax bigint,
    vendor_email character varying,
    tax_exempt boolean,
    vendor_website character varying,
    organization_type public.organization_type_enum,
    separate_checks boolean,
    purchasing_card boolean,
    account_no bigint,
    routing_no integer,
    requestor character varying,
    date_requested date
);


ALTER TABLE purchasing.vendor_application OWNER TO postgres;

--
-- Name: blanket_agreement; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.blanket_agreement (
    agreement_id character varying(255) NOT NULL,
    statement_id character varying(255),
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    description text,
    signed_date timestamp without time zone,
    agreement_method public.agreement_method_enum
);


ALTER TABLE sales.blanket_agreement OWNER TO postgres;

--
-- Name: campaign_contacts; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.campaign_contacts (
    contact_id character varying(255) NOT NULL,
    customer_id character varying(255),
    campaign_id character varying(255),
    response_status public.response_status_enum
);


ALTER TABLE sales.campaign_contacts OWNER TO postgres;

--
-- Name: campaigns; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.campaigns (
    campaign_id character varying(255) NOT NULL,
    campaign_name character varying(255),
    type public.campaign_type_enum DEFAULT 'Email'::public.campaign_type_enum,
    start_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    end_date timestamp without time zone
);


ALTER TABLE sales.campaigns OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.customers (
    customer_id character varying(255) NOT NULL,
    gl_account_id character varying(255),
    partner_id character varying(255),
    name character varying(255),
    contact_person character varying(255),
    email_address character varying(255),
    phone_number character varying(20),
    address_line1 character varying(255),
    address_line2 character varying(255),
    city character varying(100),
    postal_code character varying(20),
    country character varying(100),
    customer_type public.customer_type_enum,
    status public.status_enum,
    debt numeric(10,2) DEFAULT 0.00,
    CONSTRAINT customers_debt_check CHECK ((debt >= (0)::numeric))
);


ALTER TABLE sales.customers OWNER TO postgres;

--
-- Name: delivery_note; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.delivery_note (
    delivery_note_id character varying(255) NOT NULL,
    order_id character varying(255),
    statement_id character varying(255),
    shipment_id character varying(255),
    rework_id character varying(255),
    shipping_method public.shipping_method_enum DEFAULT 'Standard'::public.shipping_method_enum,
    tracking_num character varying(255),
    preferred_delivery_date date DEFAULT CURRENT_DATE,
    shipping_date timestamp without time zone,
    estimated_delivery timestamp without time zone,
    actual_delivery_date timestamp without time zone,
    shipment_status public.shipment_status_type DEFAULT 'Pending'::public.shipment_status_type,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE sales.delivery_note OWNER TO postgres;

--
-- Name: opportunities; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.opportunities (
    opportunity_id character varying(255) NOT NULL,
    customer_id character varying(255),
    partner_id character varying(255),
    salesrep_id character varying(255),
    estimated_value numeric(10,2),
    weighted_amount numeric(10,2),
    gross_profit_percentage numeric(10,2),
    gross_profit_total numeric(10,2),
    starting_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expected_closed_date date,
    stage public.opportunity_stage_enum,
    status public.opportunity_status_enum,
    description text,
    reason_lost text,
    interest_level public.interest_level_enum
);


ALTER TABLE sales.opportunities OWNER TO postgres;

--
-- Name: orders; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.orders (
    order_id character varying(255) NOT NULL,
    quotation_id character varying(255),
    agreement_id character varying(255),
    statement_id character varying(255),
    ext_project_request_id character varying(255),
    order_date timestamp without time zone DEFAULT now(),
    order_type public.order_type_enum
);


ALTER TABLE sales.orders OWNER TO postgres;

--
-- Name: payments; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.payments (
    payment_id character varying(255) NOT NULL,
    order_id character varying(255),
    payment_method public.payment_method_enum,
    payment_status public.single_payment_status_enum DEFAULT 'Pending'::public.single_payment_status_enum,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE sales.payments OWNER TO postgres;

--
-- Name: product_pricing; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.product_pricing (
    product_id character varying(255) NOT NULL,
    admin_product_id character varying(255),
    markup_percentage numeric(5,2) DEFAULT 20.00,
    selling_price numeric(10,2),
    demand_level public.demand_level_enum DEFAULT 'Low'::public.demand_level_enum
);


ALTER TABLE sales.product_pricing OWNER TO postgres;

--
-- Name: quotation; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.quotation (
    quotation_id character varying(255) NOT NULL,
    statement_id character varying(255),
    agreement_id character varying(255),
    date_issued timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE sales.quotation OWNER TO postgres;

--
-- Name: return; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.return (
    return_id character varying(255) NOT NULL,
    statement_id character varying(255),
    delivery_note_id character varying(255),
    return_date timestamp without time zone,
    status public.return_status,
    remarks text
);


ALTER TABLE sales.return OWNER TO postgres;

--
-- Name: sales_invoices; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.sales_invoices (
    invoice_id character varying(255) NOT NULL,
    delivery_note_id character varying(255),
    is_returned boolean,
    invoice_date timestamp without time zone DEFAULT now(),
    total_amount numeric(10,2),
    total_amount_paid numeric(10,2) DEFAULT 0,
    remaining_balance numeric(10,2) GENERATED ALWAYS AS ((total_amount - total_amount_paid)) STORED
);


ALTER TABLE sales.sales_invoices OWNER TO postgres;

--
-- Name: statement; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.statement (
    statement_id character varying(255) NOT NULL,
    customer_id character varying(255),
    salesrep_id character varying(255),
    total_amount numeric(10,2) DEFAULT 0,
    discount numeric(10,2) DEFAULT 0,
    total_tax numeric(10,2),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE sales.statement OWNER TO postgres;

--
-- Name: statement_item; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.statement_item (
    statement_item_id character varying(255) NOT NULL,
    statement_id character varying(255),
    product_id character varying(255),
    additional_service_id character varying(255),
    quantity integer,
    quantity_to_deliver integer,
    unit_price numeric(10,2),
    discount numeric(10,2),
    total_price numeric(10,2),
    tax_amount numeric(10,2),
    special_requests text,
    return_reason text,
    return_action public.return_action,
    quantity_delivered integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE sales.statement_item OWNER TO postgres;

--
-- Name: ticket; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.ticket (
    ticket_id character varying(255) NOT NULL,
    customer_id character varying(255),
    salesrep_id character varying(255),
    subject character varying(255),
    description text,
    status public.ticket_status_enum,
    priority public.ticket_priority_enum,
    type public.ticket_type_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE sales.ticket OWNER TO postgres;

--
-- Name: ticket_convo; Type: TABLE; Schema: sales; Owner: postgres
--

CREATE TABLE sales.ticket_convo (
    convo_id character varying(255) NOT NULL,
    ticket_id character varying(255),
    subject character varying(255),
    content character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE sales.ticket_convo OWNER TO postgres;

--
-- Name: additional_service; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.additional_service (
    additional_service_id character varying(255) NOT NULL,
    total_fee numeric(10,2) DEFAULT 0.00
);


ALTER TABLE services.additional_service OWNER TO postgres;

--
-- Name: additional_service_type; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.additional_service_type (
    additional_service_type_id character varying(255) NOT NULL,
    additional_service_id character varying(255),
    service_type text NOT NULL,
    service_fee numeric(10,2) NOT NULL,
    duration integer,
    date_start date NOT NULL,
    status text NOT NULL,
    total_service_fee numeric(10,2) NOT NULL,
    CONSTRAINT additional_service_type_service_type_check CHECK ((service_type = ANY (ARRAY['Maintenance'::text, 'Extended Warranty'::text, 'Priority Service'::text]))),
    CONSTRAINT additional_service_type_status_check CHECK ((status = ANY (ARRAY['Active'::text, 'Expired'::text])))
);


ALTER TABLE services.additional_service_type OWNER TO postgres;

--
-- Name: after_analysis_sched; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.after_analysis_sched (
    analysis_sched_id character varying(255) NOT NULL,
    analysis_id character varying(255),
    service_date date NOT NULL,
    technician_id character varying(255),
    description text,
    service_status text NOT NULL,
    CONSTRAINT after_analysis_sched_service_status_check CHECK ((service_status = ANY (ARRAY['Scheduled'::text, 'Completed'::text, 'Cancelled'::text, 'In Progress'::text])))
);


ALTER TABLE services.after_analysis_sched OWNER TO postgres;

--
-- Name: delivery_order; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.delivery_order (
    delivery_order_id character varying(255) NOT NULL,
    service_order_id character varying(255),
    customer_id character varying(255),
    customer_address text,
    delivery_status text NOT NULL,
    delivery_date date,
    CONSTRAINT delivery_order_delivery_status_check CHECK ((delivery_status = ANY (ARRAY['Pending'::text, 'Shipped'::text, 'Delivered'::text])))
);


ALTER TABLE services.delivery_order OWNER TO postgres;

--
-- Name: service_analysis; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_analysis (
    analysis_id character varying(255) NOT NULL,
    service_request_id character varying(255),
    analysis_date date,
    technician_id character varying(255),
    customer_id character varying(255),
    analysis_status text NOT NULL,
    analysis_description text,
    product_id character varying(255),
    contract_id character varying(255),
    labor_cost numeric(10,2),
    CONSTRAINT service_analysis_analysis_status_check CHECK ((analysis_status = ANY (ARRAY['Scheduled'::text, 'Done'::text])))
);


ALTER TABLE services.service_analysis OWNER TO postgres;

--
-- Name: service_billing; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_billing (
    service_billing_id character varying(255) NOT NULL,
    service_order_id character varying(255),
    renewal_id character varying(255),
    analysis_id character varying(255),
    service_request_id character varying(255),
    service_billing_amount numeric(10,2),
    outsource_fee numeric(10,2) DEFAULT 0.00,
    operational_cost_id character varying(255),
    total_payable numeric(10,2) DEFAULT 0.00,
    billing_status text NOT NULL,
    date_paid date,
    CONSTRAINT service_billing_billing_status_check CHECK ((billing_status = ANY (ARRAY['Unpaid'::text, 'Paid'::text]))),
    CONSTRAINT service_billing_outsource_fee_check CHECK ((outsource_fee >= (0)::numeric)),
    CONSTRAINT service_billing_service_billing_amount_check CHECK ((service_billing_amount >= (0)::numeric))
);


ALTER TABLE services.service_billing OWNER TO postgres;

--
-- Name: service_call; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_call (
    service_call_id character varying(255) NOT NULL,
    date_created timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    service_ticket_id character varying(255),
    customer_id character varying(255),
    call_type text NOT NULL,
    technician_id character varying(255),
    call_status text NOT NULL,
    date_closed timestamp without time zone,
    contract_id character varying(255),
    product_id character varying(255),
    end_date date,
    priority_level text NOT NULL,
    resolution text,
    CONSTRAINT service_call_call_status_check CHECK ((call_status = ANY (ARRAY['Open'::text, 'Closed'::text, 'In Progress'::text]))),
    CONSTRAINT service_call_call_type_check CHECK ((call_type = ANY (ARRAY['Inquiry'::text, 'Request'::text, 'Other'::text]))),
    CONSTRAINT service_call_priority_level_check CHECK ((priority_level = ANY (ARRAY['Low'::text, 'Medium'::text, 'High'::text])))
);


ALTER TABLE services.service_call OWNER TO postgres;

--
-- Name: service_contract; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_contract (
    contract_id character varying(255) NOT NULL,
    statement_item_id character varying(255),
    customer_id character varying(255),
    additional_service_id character varying(255),
    contract_description text,
    date_issued date,
    end_date date,
    product_id character varying(255),
    contract_status text NOT NULL,
    product_quantity integer DEFAULT 1,
    renewal_id character varying(255),
    renewal_date date,
    renewal_end_date date,
    CONSTRAINT service_contract_contract_status_check CHECK ((contract_status = ANY (ARRAY['Pending'::text, 'Active'::text, 'Expired'::text, 'Terminated'::text])))
);


ALTER TABLE services.service_contract OWNER TO postgres;

--
-- Name: service_order; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_order (
    service_order_id character varying(255) NOT NULL,
    analysis_id character varying(255),
    customer_id character varying(255),
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    order_total_price numeric(10,2)
);


ALTER TABLE services.service_order OWNER TO postgres;

--
-- Name: service_order_item; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_order_item (
    service_order_item_id character varying(255) NOT NULL,
    service_order_id character varying(255),
    item_id character varying(255),
    principal_item_id character varying(255),
    item_name character varying(255),
    item_quantity integer DEFAULT 1,
    item_price numeric(10,2),
    CONSTRAINT service_order_item_item_quantity_check CHECK ((item_quantity > 0))
);


ALTER TABLE services.service_order_item OWNER TO postgres;

--
-- Name: service_report; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_report (
    report_id character varying(255) NOT NULL,
    service_call_id character varying(255),
    service_ticket_id character varying(255),
    service_billing_id character varying(255),
    service_request_id character varying(255),
    renewal_id character varying(255),
    technician_id character varying(255),
    description text,
    report_status text NOT NULL,
    request_type text,
    submission_date date,
    CONSTRAINT service_report_report_status_check CHECK ((report_status = ANY (ARRAY['Draft'::text, 'Submitted'::text, 'Reviewed'::text]))),
    CONSTRAINT service_report_request_type_check CHECK ((request_type = ANY (ARRAY['Repair'::text, 'Installation'::text, 'Maintenance'::text, 'Renewal'::text, 'Other'::text])))
);


ALTER TABLE services.service_report OWNER TO postgres;

--
-- Name: service_request; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.service_request (
    service_request_id character varying(255) NOT NULL,
    service_call_id character varying(255),
    request_date date,
    customer_id character varying(255),
    technician_id character varying(255),
    request_type text NOT NULL,
    request_status text NOT NULL,
    request_description text,
    request_remarks text,
    CONSTRAINT service_request_request_status_check CHECK ((request_status = ANY (ARRAY['Pending'::text, 'Approved'::text, 'Rejected'::text, 'In Progress'::text]))),
    CONSTRAINT service_request_request_type_check CHECK ((request_type = ANY (ARRAY['Repair'::text, 'Installation'::text, 'Maintenance'::text, 'Renewal'::text, 'Other'::text])))
);


ALTER TABLE services.service_request OWNER TO postgres;

--
-- Name: warranty_renewal; Type: TABLE; Schema: services; Owner: postgres
--

CREATE TABLE services.warranty_renewal (
    renewal_id character varying(255) NOT NULL,
    service_call_id character varying(255),
    contract_id character varying(255),
    duration integer DEFAULT 1,
    renewal_warranty_start date,
    renewal_warranty_end date,
    renewal_fee numeric(10,2)
);


ALTER TABLE services.warranty_renewal OWNER TO postgres;

--
-- Data for Name: chart_of_accounts; Type: TABLE DATA; Schema: accounting; Owner: postgres
--

COPY accounting.chart_of_accounts (account_code, account_name, account_type) FROM stdin;
ACC-COA-2025-CA1010	Cash on Hand	Current Asset
ACC-COA-2025-CA1020	Cash in Bank	Current Asset
ACC-COA-2025-CA1030	Accounts Receivable	Current Asset
ACC-COA-2025-CA1040	Allowance for Doubtful Accounts	Contra-Asset
ACC-COA-2025-CA1050	Raw Materials Inventory	Current Asset
ACC-COA-2025-CA1060	Work-in-Process (WIP) Inventory	Current Asset
ACC-COA-2025-CA1070	Finished Goods Inventory	Current Asset
ACC-COA-2025-CA1080	Prepaid Expenses	Current Asset
ACC-COA-2025-CA1090	Supplier Advances	Current Asset
ACC-COA-2025-NA1100	Land & Buildings	Non-Current Asset
ACC-COA-2025-NA1110	Machinery & Equipment	Non-Current Asset
ACC-COA-2025-NA1120	Vehicles	Non-Current Asset
ACC-COA-2025-NA1130	Office Furniture & Fixtures	Non-Current Asset
ACC-COA-2025-NA1140	Computers & IT Equipment	Non-Current Asset
ACC-COA-2025-NA1150	Intangible Assets	Non-Current Asset
ACC-COA-2025-NA1160	Accumulated Depreciation	Contra-Asset
ACC-COA-2025-CL2010	Accounts Payable	Current Liability
ACC-COA-2025-CL2020	Accrued Expenses	Current Liability
ACC-COA-2025-CL2030	Taxes Payable	Current Liability
ACC-COA-2025-CL2040	Short-Term Loans Payable	Current Liability
ACC-COA-2025-CL2050	Customer Deposits	Current Liability
ACC-COA-2025-NL2100	Long-Term Loans Payable	Non-Current Liability
ACC-COA-2025-NL2110	Bonds Payable	Non-Current Liability
ACC-COA-2025-NL2120	Lease Liabilities	Non-Current Liability
ACC-COA-2025-EE3010	Owners Capital / Shareholders Equity	Equity
ACC-COA-2025-EE3020	Retained Earnings	Equity
ACC-COA-2025-EE3030	Dividends Payable	Equity
ACC-COA-2025-RR4010	Sales Revenue	Revenue
ACC-COA-2025-RR4020	Service Revenue	Revenue
ACC-COA-2025-RR4030	Discounts Allowed	Contra-Revenue
ACC-COA-2025-RR4040	Rework Cost	Contra-Revenue
ACC-COA-2025-CG5010	Raw Materials Used	Cost of Goods Sold
ACC-COA-2025-CG5020	Direct Labor	Cost of Goods Sold
ACC-COA-2025-CG5030	Factory Overhead	Cost of Goods Sold
ACC-COA-2025-CG5040	Work-in-Process Adjustments	Cost of Goods Sold
ACC-COA-2025-CG5050	Cost of Finished Goods Sold	Cost of Goods Sold
ACC-COA-2025-AE6010	Salaries & Wages	Operating Expense
ACC-COA-2025-AE6020	Office Supplies & Equipment	Operating Expense
ACC-COA-2025-AE6030	Rent & Utilities	Operating Expense
ACC-COA-2025-AE6040	Depreciation	Operating Expense
ACC-COA-2025-AE6050	Software & IT Expenses	Operating Expense
ACC-COA-2025-AE6060	Legal & Professional Fees	Operating Expense
ACC-COA-2025-SD6100	Marketing & Advertising	Operating Expense
ACC-COA-2025-SD6110	Sales Commissions	Operating Expense
ACC-COA-2025-SD6120	Shipping & Freight Costs	Operating Expense
ACC-COA-2025-SD6130	Packaging Costs	Operating Expense
ACC-COA-2025-OI7010	Interest Income	Other Income
ACC-COA-2025-OI7020	Gain on Sale of Assets	Other Income
ACC-COA-2025-OI7030	Investment Income	Other Income
ACC-COA-2025-OE7100	Interest Expense	Other Expense
ACC-COA-2025-OE7110	Exchange Rate Losses	Other Expense
ACC-COA-2025-OE7120	Penalties & Fines	Other Expense
ACC-COA-2025-IB8010	Budgetary Control/Reserve	Budgetary Control
ACC-COA-2025-IB8020	Encumbrance Control	Budgetary Control
\.


--
-- Data for Name: financial_report; Type: TABLE DATA; Schema: accounting; Owner: postgres
--

COPY accounting.financial_report (report_id, report_type, total_cost, start_date, end_date, generated_by) FROM stdin;
ACC-REP-2025-b62d30	Accounts Receivable	126543.23	2025-01-05	2025-01-12	accounting
ACC-REP-2025-947e9b	Cash on Hand	45782.11	2025-01-10	2025-01-17	accounting
ACC-REP-2025-20c478	Cash in Bank	320000.00	2025-01-12	2025-02-12	accounting
ACC-REP-2025-4ba86e	Accounts Payable	89000.50	2025-01-07	2025-01-14	accounting
ACC-REP-2025-6d9d4a	Raw Materials Inventory	23000.99	2025-01-03	2025-02-03	accounting
ACC-REP-2025-29df22	Work-in-Process (WIP) Inventory	75433.67	2025-01-11	2025-01-18	accounting
ACC-REP-2025-6461d4	Finished Goods Inventory	134000.12	2025-01-15	2025-02-15	accounting
ACC-REP-2025-3c2939	Owner’s Capital / Shareholder’s Equity	410000.00	2025-01-01	2025-02-01	accounting
ACC-REP-2025-ba791c	Sales Revenue	478000.88	2025-01-01	2025-01-29	accounting
ACC-REP-2025-766a25	Service Revenue	180000.25	2025-01-06	2025-01-13	accounting
ACC-REP-2025-1ffb23	Raw Materials Used	56200.00	2025-01-09	2025-01-16	accounting
ACC-REP-2025-94e40f	Direct Labor	74000.50	2025-01-04	2025-01-11	accounting
ACC-REP-2025-7ee680	Cost of Finished Goods Sold	121000.77	2025-01-10	2025-01-17	accounting
ACC-REP-2025-5dc7f0	Salaries & Wages	86000.30	2025-01-12	2025-01-19	accounting
ACC-REP-2025-739cad	Shipping & Freight Costs	25200.20	2025-01-13	2025-01-20	accounting
ACC-REP-2025-d99098	Packaging Costs	16000.45	2025-01-05	2025-01-12	accounting
ACC-REP-2025-e12e74	Budgetary Control / Reserve	59000.00	2025-01-08	2025-01-15	accounting
ACC-REP-2025-9ea2d4	Encumbrance Control	38800.60	2025-01-02	2025-01-09	accounting
ACC-REP-2025-6a9f67	Accounts Receivable	135400.00	2025-01-06	2025-01-13	accounting
ACC-REP-2025-cb7f46	Cash on Hand	37890.77	2025-01-10	2025-01-17	accounting
ACC-REP-2025-793e38	Cash in Bank	290000.00	2025-01-09	2025-02-09	accounting
ACC-REP-2025-5ba92a	Accounts Payable	90500.00	2025-01-04	2025-01-11	accounting
ACC-REP-2025-57896e	Raw Materials Inventory	24600.00	2025-01-11	2025-02-11	accounting
ACC-REP-2025-109a57	Work-in-Process (WIP) Inventory	81200.33	2025-01-07	2025-01-14	accounting
ACC-REP-2025-56deb7	Finished Goods Inventory	143000.00	2025-01-01	2025-02-01	accounting
ACC-REP-2025-713dbf	Owner’s Capital / Shareholder’s Equity	420000.55	2025-01-03	2025-02-03	accounting
ACC-REP-2025-e82fc7	Sales Revenue	465500.95	2025-01-08	2025-01-15	accounting
ACC-REP-2025-abbde0	Service Revenue	174000.00	2025-01-13	2025-01-20	accounting
ACC-REP-2025-008777	Raw Materials Used	53400.00	2025-01-05	2025-01-12	accounting
ACC-REP-2025-34499e	Direct Labor	68000.00	2025-01-02	2025-01-09	accounting
ACC-REP-2025-6215b5	Cost of Finished Goods Sold	109500.00	2025-01-04	2025-01-11	accounting
ACC-REP-2025-db1c80	Salaries & Wages	87500.00	2025-01-09	2025-01-16	accounting
ACC-REP-2025-06a1f2	Shipping & Freight Costs	24500.00	2025-01-06	2025-01-13	accounting
ACC-REP-2025-28a04f	Packaging Costs	15500.00	2025-01-11	2025-01-18	accounting
ACC-REP-2025-65f970	Budgetary Control / Reserve	52500.00	2025-01-07	2025-01-14	accounting
ACC-REP-2025-f38bd9	Encumbrance Control	36500.00	2025-01-03	2025-01-10	accounting
ACC-REP-2025-33d615	Accounts Receivable	141000.00	2025-01-08	2025-01-15	accounting
ACC-REP-2025-f7aa00	Cash on Hand	41000.00	2025-01-12	2025-01-19	accounting
ACC-REP-2025-3b8cf2	Cash in Bank	330000.00	2025-01-01	2025-02-01	accounting
ACC-REP-2025-4c567b	Accounts Payable	94500.00	2025-01-05	2025-01-12	accounting
ACC-REP-2025-7ba8e2	Raw Materials Inventory	25500.00	2025-01-10	2025-02-10	accounting
ACC-REP-2025-76a548	Work-in-Process (WIP) Inventory	79900.00	2025-01-13	2025-01-20	accounting
ACC-REP-2025-b8af27	Finished Goods Inventory	140000.00	2025-01-07	2025-02-07	accounting
ACC-REP-2025-3dfb4f	Owner’s Capital / Shareholder’s Equity	430000.00	2025-01-04	2025-02-04	accounting
ACC-REP-2025-c2f412	Sales Revenue	470000.00	2025-01-09	2025-02-09	accounting
ACC-REP-2025-7537c0	Service Revenue	182000.00	2025-01-06	2025-01-13	accounting
ACC-REP-2025-174d36	Raw Materials Used	54800.00	2025-01-02	2025-01-09	accounting
ACC-REP-2025-1be727	Direct Labor	69000.00	2025-01-01	2025-01-08	accounting
ACC-REP-2025-57111f	Cost of Finished Goods Sold	115000.00	2025-01-03	2025-01-10	accounting
\.


--
-- Data for Name: general_ledger_accounts; Type: TABLE DATA; Schema: accounting; Owner: postgres
--

COPY accounting.general_ledger_accounts (gl_account_id, account_name, account_code, account_id, status, created_at) FROM stdin;
ACC-GLA-2025-2dc665	Bank - 1122	ACC-COA-2025-CA1020	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-d50471	Inventory	ACC-COA-2025-CA1070	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-936ca5	Mr. Zubair & Co.	ACC-COA-2025-CL2010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-b1926b	Kazim Ahmed	ACC-COA-2025-CL2050	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-c9d374	Kineteq/Oweners Equity	ACC-COA-2025-EE3010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-fd7060	Salary Expense	ACC-COA-2025-AE6010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-3b5976	Sales Revenue	ACC-COA-2025-RR4010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-ac0ed4	Cost of Goods Sold	ACC-COA-2025-CG5050	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-a4b8ca	Electricity Expense	ACC-COA-2025-AE6030	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-733667	Government Taxes Payable	ACC-COA-2025-CL2030	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-1759d2	Raw Materials Used	ACC-COA-2025-CG5010	\N	Active	2025-03-18 08:15:14
ACC-GLA-2025-dd4b41	BANK - BDO	ACC-COA-2025-CL2010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-e3e09c	Shipping Cost	ACC-COA-2025-SD6120	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-acd810	Customer - botik	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-1c395a	Work-in-Process Inventory	ACC-COA-2025-CA1060	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-2787cd	Raw Materials Inventory	ACC-COA-2025-CA1050	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-2f670b	Raw Materials Used	ACC-COA-2025-CG5010	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-039fc9	Customer - St. Luke Medical Center	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-8c693c	Customer - Makati Medical Center	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-509f7e	Customer - Manila Doctors Hospital	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-3155c9	Customer - Cardinal Santos Medical Center	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-88e6e5	Customer - Philippines General Hospital	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-41cdd0	Customer - World Citi Medical Center	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-c8463f	Customer - Metro Manila Medical Center	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-72c90c	Customer - Capitol Medical Center	ACC-COA-2025-CA1030	\N	Active	2025-03-18 21:06:48
ACC-GLA-2025-b5c192	Vendor- BioFlex Composites	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-c1118a	Vendor- BioGrade Metals	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-34eacb	Vendor- CryoBond Precision	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-6a3948	Vendor- DuraWell Pro Ltd.	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-41c5ff	Vendor- MedicalTradingCorps	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-017530	Vendor- MediCore Materials Inc.	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-ac1ed3	Vendor- NeoCarewell Industries Ltd.	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-63b70b	Vendor- PharmaTools Ltd.	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-eb3240	Vendor- PureForm Medical	ACC-COA-2025-CL2010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-53de6d	Employee- Kate Tan	ACC-COA-2025-AE6010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-74df1e	Employee- James Marticio	ACC-COA-2025-AE6010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-8310ea	Employee- Robert Santiago	ACC-COA-2025-AE6010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-6f2990	Employee- Maria Lopez	ACC-COA-2025-AE6010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-4d41c3	Employee- David Cruz	ACC-COA-2025-AE6010	\N	Active	2025-03-18 21:23:27
ACC-GLA-2025-f38b81	Budgetary Control - Accounting	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-fc9308	Budgetary Control - Administration	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-116c7c	Budgetary Control - Distribution	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-f4415b	Budgetary Control - Finance	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-53c7bb	Budgetary Control - Human Resource	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-278cd3	Budgetary Control - Inventory	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-0c9ca9	Budgetary Control - Management	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-1a46b4	Budgetary Control - Material Resource Planning	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-ff5f5d	Budgetary Control - Operations	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-a7e9d1	Budgetary Control - Production	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-4948d4	Budgetary Control - Project Management	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-d00fe5	Budgetary Control - Purchasing	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-a2a6ba	Budgetary Control - Sales	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-12e251	Budgetary Control - Services	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-3ca18c	Budgetary Control - Maintenance & Facilities	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-0c4f4a	Budgetary Control - IT & Technical Support	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-f28c5d	Budgetary Control - Quality Assurance & Compliance	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-e35107	Budgetary Control - Health, Safety, and Environment	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-986d6a	Budgetary Control - Security	ACC-COA-2025-IB8010	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-05dece	Encumbrance Control	ACC-COA-2025-IB8020	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-aebd85	Rework Cost	ACC-COA-2025-RR4030	\N	Active	2025-03-08 02:00:00
ACC-GLA-2025-46da91	St. Luke's Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-11c3dc	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-ec62c8	Makati Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-581de7	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-5fe592	The Medical City	ACC-COA-2025-CA1030	SALES-CUST-2025-ee8185	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-0f86be	Asian Hospital and Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-a06fff	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-65eca9	Philippine General Hospital	ACC-COA-2025-CA1030	SALES-CUST-2025-303e3d	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-91e0f2	Manila Doctors Hospital	ACC-COA-2025-CA1030	SALES-CUST-2025-e3832a	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-be1609	Cardinal Santos Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-bfc826	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-4d9b75	World Citi Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-920ea7	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-1787a5	Davao Doctors Hospital	ACC-COA-2025-CA1030	SALES-CUST-2025-96421d	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-eb1bda	Cebu Doctors University Hospital	ACC-COA-2025-CA1030	SALES-CUST-2025-16f160	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-36c684	Metro Manila Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-1ced77	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-88b24e	East Avenue Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-393e34	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-efd9df	Capitol Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-11316f	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-e6796a	Ospital ng Makati	ACC-COA-2025-CA1030	SALES-CUST-2025-461682	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-b92fbd	Lung Center of the Philippines	ACC-COA-2025-CA1030	SALES-CUST-2025-5ed6e4	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-1e785f	National Kidney and Transplant Institute	ACC-COA-2025-CA1030	SALES-CUST-2025-a5e198	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-f0e93a	Rizal Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-a1283c	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-3d3b62	Quirino Memorial Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-a53d8e	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-138639	Jose R. Reyes Memorial Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-e1bf4f	Active	2025-04-11 23:12:09.071108
ACC-GLA-2025-32676a	Perpetual Help Medical Center	ACC-COA-2025-CA1030	SALES-CUST-2025-6f4365	Active	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: journal_entries; Type: TABLE DATA; Schema: accounting; Owner: postgres
--

COPY accounting.journal_entries (journal_id, journal_date, description, total_debit, total_credit, invoice_id, currency_id) FROM stdin;
ACC-JOE-2025-024ba5	2022-01-05	Sales Order	77984.53	77984.53	\N	\N
ACC-JOE-2025-251568	2022-01-05	Sales Order	3544677.76	3544677.76	\N	\N
ACC-JOE-2025-13c37d	2022-01-05	Sales Order	437073.00	437073.00	\N	\N
ACC-JOE-2025-4ab729	2022-01-06	Production Document Transaction	150.00	150.00	\N	\N
ACC-JOE-2025-f9284a	2022-01-06	Production Document Transaction	175.00	175.00	\N	\N
ACC-JOE-2025-b1a3ef	2022-01-07	MRP Overall Production Cost	2000.00	2000.00	\N	\N
ACC-JOE-2025-6ef370	2022-01-07	MRP Overall Production Cost	1830.00	1830.00	\N	\N
ACC-JOE-2025-91a4f5	2022-01-07	MRP Overall Production Cost	2600.00	2600.00	\N	\N
ACC-JOE-2025-46fdc1	2022-01-08	Payroll Expense	5854.55	5854.55	\N	\N
ACC-JOE-2025-54966a	2022-01-08	Payroll Expense	1850.00	1850.00	\N	\N
ACC-JOE-2025-2944be	2022-01-09	Production Order Cost	1500.00	1500.00	\N	\N
ACC-JOE-2025-d5ed01	2022-01-09	Production Order Cost	800.00	800.00	\N	\N
\.


--
-- Data for Name: journal_entry_lines; Type: TABLE DATA; Schema: accounting; Owner: postgres
--

COPY accounting.journal_entry_lines (entry_line_id, gl_account_id, journal_id, debit_amount, credit_amount, description) FROM stdin;
ACC-JEL-2025-af9425	\N	\N	77984.53	0.00	Accounts Receivable - Sales Order
ACC-JEL-2025-a559b0	\N	\N	0.00	77984.53	Sales Revenue
ACC-JEL-2025-ba8252	\N	\N	3544677.76	0.00	Accounts Receivable - Sales Order
ACC-JEL-2025-f4a625	\N	\N	0.00	3544677.76	Sales Revenue
ACC-JEL-2025-b6be84	\N	\N	437073.00	0.00	Accounts Receivable - Sales Order
ACC-JEL-2025-4034e0	\N	\N	0.00	437073.00	Sales Revenue
ACC-JEL-2025-caef01	\N	\N	150.00	0.00	Work-in-Process Inventory
ACC-JEL-2025-b86b07	\N	\N	0.00	150.00	Raw Materials Used for Production
ACC-JEL-2025-f69e8a	\N	\N	175.00	0.00	Work-in-Process Inventory
ACC-JEL-2025-d118d4	\N	\N	0.00	175.00	Raw Materials Used for Production
ACC-JEL-2025-c2e74e	\N	\N	2000.00	0.00	Cost of Finished Goods Sold
ACC-JEL-2025-ddeb91	\N	\N	0.00	2000.00	Sales Revenue
ACC-JEL-2025-b94cb1	\N	\N	1830.00	0.00	Cost of Finished Goods Sold
ACC-JEL-2025-4df275	\N	\N	0.00	1830.00	Sales Revenue
ACC-JEL-2025-23dd1f	\N	\N	2600.00	0.00	Cost of Finished Goods Sold
ACC-JEL-2025-d6624c	\N	\N	0.00	2600.00	Sales Revenue
ACC-JEL-2025-41140b	\N	\N	5854.55	0.00	Payroll Expense
ACC-JEL-2025-081a8b	\N	\N	0.00	5854.55	Payroll Payment
ACC-JEL-2025-c6753d	\N	\N	1850.00	0.00	Payroll Expense
ACC-JEL-2025-8a9c5c	\N	\N	0.00	1850.00	Payroll Payment
ACC-JEL-2025-af7ac7	\N	\N	1500.00	0.00	Work-in-Process Inventory Increase
ACC-JEL-2025-2332b3	\N	\N	0.00	1500.00	Raw Materials Used
ACC-JEL-2025-6c7230	\N	\N	800.00	0.00	Work-in-Process Inventory Increase
ACC-JEL-2025-ebc3f3	\N	\N	0.00	800.00	Raw Materials Used
\.


--
-- Data for Name: official_receipts; Type: TABLE DATA; Schema: accounting; Owner: postgres
--

COPY accounting.official_receipts (or_id, invoice_id, customer_id, or_date, settled_amount, remaining_amount, payment_method, reference_number, created_by) FROM stdin;
ACC-OFR-2025-ed16f2	\N	\N	2025-04-02	250.00	250.00	Credit Card	REF-1001	Admin
ACC-OFR-2025-331a7b	\N	\N	2025-03-20	1200.00	0.00	Bank Transfer	REF-1002	Admin
ACC-OFR-2025-cebb32	\N	\N	2025-03-12	1000.00	1500.00	Cash	REF-1003	Admin
ACC-OFR-2025-49b6e1	\N	\N	2025-03-25	1800.00	0.00	Credit Card	REF-1004	Admin
ACC-OFR-2025-7d971e	\N	\N	2025-04-06	400.00	350.00	Bank Transfer	REF-1005	Admin
ACC-OFR-2025-1159f8	\N	\N	2025-03-17	1500.00	1500.00	Cash	REF-1006	Admin
ACC-OFR-2025-669bc2	\N	\N	2025-03-22	950.00	0.00	Credit Card	REF-1007	Admin
ACC-OFR-2025-2c3a0c	\N	\N	2025-04-11	2000.00	2000.00	Bank Transfer	REF-1008	Admin
ACC-OFR-2025-0fa6ea	\N	\N	2025-03-14	750.00	2000.00	Cash	REF-1009	Admin
ACC-OFR-2025-e52da9	\N	\N	2025-03-18	600.00	0.00	Credit Card	REF-1010	Admin
\.


--
-- Data for Name: assets; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.assets (asset_id, asset_name, purchase_date, purchase_price, serial_no, content_id) FROM stdin;
ADMIN-ASSET-2025-d4eb59	Laptop - Dell XPS 15	2024-01-10	1800.00	SN0001	\N
ADMIN-ASSET-2025-204a43	Office Chair - Ergonomic	2023-12-15	250.00	SN0002	\N
ADMIN-ASSET-2025-5c3f34	Printer - HP LaserJet Pro	2024-02-05	350.00	SN0003	\N
ADMIN-ASSET-2025-1f8b05	Projector - Epson X500	2023-11-20	700.00	SN0004	\N
ADMIN-ASSET-2025-ce1097	Desk - Wooden Executive	2024-03-01	500.00	SN0005	\N
ADMIN-ASSET-2025-108036	Monitor - LG UltraWide	2024-02-10	900.00	SN0006	\N
ADMIN-ASSET-2025-692d29	Keyboard - Mechanical RGB	2023-12-25	150.00	SN0007	\N
ADMIN-ASSET-2025-d2098f	Mouse - Logitech MX Master 3	2024-01-15	100.00	SN0008	\N
ADMIN-ASSET-2025-86767d	External Hard Drive - 2TB	2024-02-28	180.00	SN0009	\N
ADMIN-ASSET-2025-4a2f1b	Conference Speaker - Jabra Speak 750	2023-11-30	300.00	SN0010	\N
ADMIN-ASSET-2025-d78933	Tablet - iPad Pro	2024-03-05	1200.00	SN0011	\N
ADMIN-ASSET-2025-01845b	Smartphone - Samsung Galaxy S24	2024-02-18	1100.00	SN0012	\N
ADMIN-ASSET-2025-b3cebd	Scanner - Canon imageFORMULA	2024-01-22	400.00	SN0013	\N
ADMIN-ASSET-2025-391078	Router - Cisco RV340	2024-03-02	250.00	SN0014	\N
ADMIN-ASSET-2025-bc0967	Filing Cabinet - Steel 4-Drawer	2024-02-14	350.00	SN0015	\N
ADMIN-ASSET-2025-104f69	Webcam - Logitech Brio	2024-03-09	200.00	SN0016	\N
ADMIN-ASSET-2025-08abb3	Whiteboard - Magnetic	2024-01-29	120.00	SN0017	\N
ADMIN-ASSET-2025-54466a	Speaker System - Bose Companion	2024-02-08	450.00	SN0018	\N
ADMIN-ASSET-2025-d52f63	UPS - APC Smart-UPS	2024-03-04	600.00	SN0019	\N
ADMIN-ASSET-2025-148daa	Air Purifier - Dyson Pure Cool	2024-02-27	550.00	SN0020	\N
\.


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.audit_log (log_id, user_id, action, "timestamp", ip_address) FROM stdin;
ADMIN-LOG-2025-4778af	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eb7838	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-da55a6	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b6e63	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6c12c	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d5522	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4f4579	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ba441	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-76f106	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a189e	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db4a32	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1987f5	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f3144	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f5525	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a17db	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9387d	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5a629	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc2493	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-416a35	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72fb4c	\N	INSERT on table external_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d0169f	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8463a1	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a79782	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-730d36	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-df256e	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7d61eb	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-118834	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-397423	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b23e45	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6581c2	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-66ad9c	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-448778	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e3dd31	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cb4a73	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ebc641	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2d7b79	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-00826c	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c9c57	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-476e5d	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e2a4c	\N	INSERT on table external_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fcf72e	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3c22ee	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b696f	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a48298	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cfff33	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c45129	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-855e04	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6cf257	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4bc603	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0a4f17	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d5e8e5	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-78ad9a	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7ef602	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b79027	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ce8a5f	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb657f	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-33a108	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1d5041	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b7b336	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b3d79a	\N	INSERT on table external_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1069f5	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ff7d87	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-103ff6	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b7a3de	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6791b5	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a686e	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f1fe5	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c1b646	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e2abe0	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-671fcb	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5ce4a2	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ec3880	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19fb74	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6bd659	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-469e42	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-678a10	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c00306	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-448ea5	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d6f4e4	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-535bda	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae50f4	\N	INSERT on table external_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f676ed	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-69999a	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc60e1	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c2623a	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57f853	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6dda17	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7444a8	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1c73e4	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4fa6cd	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-619ac0	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d8d36	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-60e218	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5b6c46	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f3f89e	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a0e5ed	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea0a60	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fc9a5f	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2931bd	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a110c	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f602c	\N	INSERT on table external_project_warranty	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-36df77	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fea3a8	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-55db37	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-321257	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af623f	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-802d1a	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-060873	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5b0c9	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-801020	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8288d2	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-91fc10	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-87fa26	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-251d47	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-75b950	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d51af	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d0b21	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b7f1e	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5cd482	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b201c2	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5a3d52	\N	INSERT on table external_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aca1a0	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f9a8f3	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8ffef7	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-01b27d	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae700e	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bea964	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8bd25a	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dbc17d	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea2213	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-961ffe	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-90688e	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32b13a	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4d1e20	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-678215	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b535da	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3719db	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-05de4d	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4531b1	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0290b5	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-589ac7	\N	INSERT on table external_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d292c7	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7acaa8	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3a3772	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1377a9	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f82d53	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-17948f	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-46984e	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-44864c	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2c92ad	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-109bcf	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-240f2a	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b154d8	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f29fbc	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c2765f	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-115356	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae21c8	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19a75d	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-17f6a6	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb30c4	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-491c91	\N	INSERT on table internal_project_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c33a7e	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ab6787	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2da0fa	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1c93cf	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f52646	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7daa9b	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b840c	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e1ee34	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af1f90	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d0b70	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-abcd5d	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7e636c	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a19918	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ce415	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f405e	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-761b98	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b6e7d0	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-07c9e9	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eddec3	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f57f8	\N	INSERT on table internal_project_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-81cbb7	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1554e4	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f63043	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d49af	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-85f3f1	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e19a75	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e721c	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-657565	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-65a6e0	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e81419	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7cdd00	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7aa069	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e20e4e	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b45866	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2bfbb7	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-58dcec	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fae595	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bda4a2	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-606f82	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7cb21d	\N	INSERT on table internal_project_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-69dac2	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6198df	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c40cdd	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-de912b	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b22fb2	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e86e7f	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a8802a	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d58033	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b18bc9	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d7aed6	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-64f3ff	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-61f8e6	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dcfd49	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a6041c	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8e495b	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2d6517	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f54eec	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b1d26b	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-31dc7a	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bbda23	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3e889f	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-465a62	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ddcee6	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-be59bf	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d2544e	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c4e365	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-63e875	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3bf5bf	\N	INSERT on table internal_project_labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a4b0fb	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-de03fc	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6c870d	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aad197	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b9760	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a9700c	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc7635	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aba7fc	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-716491	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-234a57	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7d4d9a	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f055e1	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9dfbc7	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7d8067	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e58ad0	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-25dd3d	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f4762	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bc1a0e	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c0a279	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3cb9c3	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d3d01	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-84afc2	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3660cc	\N	INSERT on table internal_project_task_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4008fb	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f6c91	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f8b544	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-96fc9c	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8cf681	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c7a917	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3e308f	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2225f	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b4c4f	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-27740f	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-26b6a9	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6dd0d	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e50498	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ef78f2	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e05d9c	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6086cb	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c47db0	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-641e89	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a538bc	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6cfa5f	\N	INSERT on table report_monitoring	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d3aa70	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-188b68	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0fa03	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e39c1c	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ccd0ce	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-86b8e1	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-422247	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f4005	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1362e0	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d8b868	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f94af	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bd8412	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1dbda2	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-487c1d	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-44dd36	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19daf6	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6ba5bc	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b1f8b	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-69dfef	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-82f3ec	\N	INSERT on table external_project_equipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-79503b	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af2a41	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ed778e	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f1ca2	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b2300	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5e8fee	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1aae11	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0c450e	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-26214b	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fd4476	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d19215	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6542a2	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b175b2	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2a07cc	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8aa55d	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3daaf9	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0c2a8e	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f7ced4	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-127b02	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-630e1c	\N	INSERT on table internal_project_cost_management	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e1329c	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-be7569	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3bee76	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4157cd	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd86c3	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-608053	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-647808	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aee437	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c2ed8	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1faa77	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19d4a7	\N	INSERT on table bill_of_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6a4174	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-229671	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-533bf8	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9a160b	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a954ad	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ebfd02	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5baaba	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad6cbe	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-24974c	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e0a15	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34f2a5	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e0311	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-55267b	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cb3408	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7a85c3	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-530b85	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-013d65	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-727713	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-008d69	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11e2fe	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3c54b1	\N	INSERT on table product_mats	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-81e77a	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc02c3	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0cc1ff	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6b3d1	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e63df6	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4ede2f	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-40f568	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5671f	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9331a4	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e8d670	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dad071	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d623c7	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5cdfa6	\N	INSERT on table labor_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b6b16f	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1701d5	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-373b52	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-18e2b4	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0928af	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5ed5ef	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f2a23	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4633b8	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3cc0db	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e789e8	\N	INSERT on table principal_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9a722e	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c30177	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-80f313	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c644e4	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea6f78	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b7d66	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-16e324	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-920cae	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-26f33d	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-17eef7	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0ec94	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae9d3f	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a30644	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af4e98	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1da19b	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af0b33	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2c5a60	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-876fb7	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9a61eb	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c070ff	\N	INSERT on table labor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a52a0	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-74cf8c	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-39bf43	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e26412	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d4a3cb	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c138f4	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ff418d	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-00b9be	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa675d	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6046a2	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4b9112	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1c057e	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f68bb2	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d5c106	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-12d648	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fcf6c9	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb9fd9	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-01eb45	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-de66bb	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fdc2ea	\N	INSERT on table equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8ba186	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-586cd3	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c916e2	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-529fcb	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-33b331	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11be0a	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c1de38	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c378c5	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-52bf8a	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-da8edd	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f1846	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eb512d	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f75ba	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc4ae4	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a5c8ee	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b4fed	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48875e	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a3dd3	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-76627b	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9afc7e	\N	INSERT on table project_equipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b274e1	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d4d629	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c3ca7f	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-525caf	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-924148	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a09ea	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2d4d2e	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-24e9e3	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-883b39	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-317852	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c998a4	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-40f3cd	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d66248	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f1321e	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bda075	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-09db06	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-52de53	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-825ab1	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-844f88	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5ecda	\N	INSERT on table production_orders_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c96e6a	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19a316	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6bae40	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bcf88f	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d9bc74	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-426f68	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ed1b99	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d30d48	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9076d7	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e257d5	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f9aadd	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e060e1	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f77fc	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a778ef	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-159e41	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7a64ff	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9cca41	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0f1b8c	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-083975	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f74ff1	\N	INSERT on table production_orders_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-807aa3	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ecfde4	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-744c88	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f2218	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d93735	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1858fc	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9de171	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-420ff2	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-218019	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a81704	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f70361	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ef132f	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e176f2	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6891f9	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6efed4	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34c0e4	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9562ee	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-39b967	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0590e7	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e209a	\N	INSERT on table rework_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5211d0	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2306da	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e27604	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6a1b9a	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d56e20	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a51159	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-125a41	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b98a6a	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bcf517	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-12a37c	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-839420	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bdf625	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f31766	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f8fde3	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3b0423	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f8593e	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d66a6f	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d76be9	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-16615f	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c28592	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c622f8	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5025e2	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-99d634	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e890a8	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-869457	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-561075	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e2701	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd0668	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-36deb1	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1d51db	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-749e2b	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-65398e	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5cc7a2	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f137d8	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ff56cf	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-38bac8	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-418171	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7a5ae7	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aa16c4	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-90f41b	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5f2342	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e1cea	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-440535	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a37525	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f9c50e	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fd1dca	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bfc723	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0bd5d2	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5afb2	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-62a966	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-81bc32	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2ebd7e	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cf2f48	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ffcc1a	\N	INSERT on table chart_of_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a860f2	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e8d54d	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b64ac	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8ae1f5	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a1cdef	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aefd6f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4cec6c	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-10bb3f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7ca471	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-39698a	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-94a2b2	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0b227f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b0eec4	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d5a293	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5351d3	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-859703	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b183c2	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bc13d0	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-30c48f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e416a7	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-20836b	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-64c9f8	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8206c1	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-87605d	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6dcd84	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-404d90	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ff1a12	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2c030	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6a24a2	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d8d18c	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d2e57c	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e96b49	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2d0882	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ed9b7a	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b8a14	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0edcfb	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8f29e1	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-573588	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0b14cf	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9c690d	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-256b50	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a755b5	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5f124d	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-56e157	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-98bfb7	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d6a8f7	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4b2df5	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-188faf	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-828315	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-07890a	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2e2690	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8e6fbc	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7244da	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5160c6	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72da5a	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48954b	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ab959f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8c3ef7	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-250f5f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-10dfa8	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d32971	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c5500	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f33e9a	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6d0911	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6ca15	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e80fb	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ecad4f	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5ecc51	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b972c0	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c35348	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f01e25	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a784d	\N	INSERT on table journal_entries	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7856c	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2799c8	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b87ab4	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2cdd6c	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6ca921	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7637e9	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a7fcc	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b13f3f	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a2a84	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-59c39a	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f6ebc	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e23699	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee5522	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-567169	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-503eff	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cde62a	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-daa933	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fd9217	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a1c035	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0dc523	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e33e12	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af847b	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-77067c	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-62350b	\N	INSERT on table journal_entry_lines	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-41305a	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-51571e	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e04be6	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-653eee	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c8b714	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-383984	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-315701	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5f4dfb	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a7aec1	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-303425	\N	INSERT on table official_receipts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-168384	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f04bd4	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd1455	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8c7d29	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0bd254	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-586cdb	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d36691	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-971d3a	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8031f9	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-275f3c	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-348d52	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f11c87	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1cca8d	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-63eceb	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ad651	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-44c5ca	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57cc57	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5071d1	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54e6c0	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5f6de9	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc8c8c	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b973f6	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-386f07	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ef57f4	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bde1ad	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b553fc	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-43065a	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-982142	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eb970b	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-46449b	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f2599b	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4d52e1	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2f051f	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-01bd70	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32e0ef	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8255ca	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c2d32b	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7e7568	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-13b1b0	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-712fe4	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b283b5	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3101da	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-91d3af	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4bbc9c	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-99f57e	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ce0040	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2155c0	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0f2ca5	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b159b	\N	INSERT on table financial_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-43ce38	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ecc15c	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0001f3	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e3f4b0	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d05ebb	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ef2f99	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-be25cf	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9788cc	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2f6b64	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8bfdc3	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-71a8f5	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d5789	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c7c52	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b1435a	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1c9b49	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a0a99	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9bc937	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-382687	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-53d2b2	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-998487	\N	INSERT on table return	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-81225e	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-64749c	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5bc958	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d95c59	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a485e6	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-58be54	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1fd6e9	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b2147d	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-116072	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a26ce6	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-711ba2	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-36c69f	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8bc4f4	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-721ee4	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a5c0ac	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-373f35	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a6449	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-60f4f7	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4882b7	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2a029	\N	INSERT on table opportunities	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2da0c9	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-feb814	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-210575	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-40ad20	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-471887	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c712d1	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-afde91	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f57e3	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bdf542	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-de3bcd	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d41e34	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ada8ac	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3dc7d4	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-20431b	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4b7a5b	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a671d9	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7150a5	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c3faf6	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aee9f0	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-02e376	\N	INSERT on table campaigns	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-809847	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3496e7	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-09cb9f	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0be659	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c4b045	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b53131	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9aafd1	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5a7f10	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5138ac	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a8de87	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d940c0	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e39e24	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f93b98	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-69e727	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28a535	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-78dd99	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32d232	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e56b6	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-237182	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bd0739	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c6f971	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2d66ee	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a747fe	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a376c3	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54ce90	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-20b0c1	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f89a84	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-07081a	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0b3ba	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2471c4	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9c6d90	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f7ca7f	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7e15cb	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3e1530	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-515008	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bbbed8	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2c8612	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0bb200	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ab22f7	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-25ec55	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-21227c	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-60c7bc	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cbf3bf	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-935a71	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ec709c	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-431ef9	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d0c5b	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0db13	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-492e33	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-604174	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-85ccaa	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cb4275	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-feec88	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-026e40	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e1525	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-010b6d	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c1624	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a5ef9	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3c3a76	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aab6eb	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4ceb64	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e08944	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-52a761	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-81ab74	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0eb01	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-884aaf	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8604b8	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-46b2b6	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32a5c5	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9444e7	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-960e15	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-080326	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4e9b4d	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-638e60	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db3961	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-188d3b	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28bd1f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9170bb	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5271df	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8db24a	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1664de	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ffd25	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6281c6	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7dd35e	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-461228	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c7df5d	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-407343	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6d15f2	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-70c4c8	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7ff512	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f1406a	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-96c27a	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-870342	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8f43b9	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f04cd4	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32426f	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28a5a1	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2c647a	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aafc25	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ec0288	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f9be8	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-53c68b	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57eafe	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b3b94c	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72d365	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e187b	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0bce7f	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b13d76	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ce3b7c	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a19e2d	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2be99c	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d2a083	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-14c4c3	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-04f53e	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f306d	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db9a5c	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fbd822	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2bbf74	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-edae87	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57faf4	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-660ca9	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e79110	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-06d769	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1595f1	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa636f	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6653b9	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e1fecb	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f771c8	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e04060	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28bbcb	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fe8504	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-643141	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-03b1f6	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6bb964	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0b7ed7	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0fb5d	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a69ca7	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b64373	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b37e3	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9eb475	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0cbc54	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-44aca5	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8fe25b	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6afc91	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48f114	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1da6ba	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-710fa6	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c85049	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2cd367	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a0382f	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ebe1df	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d68e80	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-20bdda	\N	INSERT on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f8557a	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7fca64	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d38bc3	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28be34	\N	INSERT on table general_ledger_accounts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-745f35	\N	UPDATE on table customers	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32ce90	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ee15c	\N	UPDATE on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-016193	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b9e872	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b585dd	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eb4daf	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e05f9c	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-454df7	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-18f084	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e508e3	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-73228b	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7af6af	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d7ae8e	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2010a	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e2b5d	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aa6c3d	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-78e0bd	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-803b0a	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9981c5	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8db3eb	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34445e	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-22ff49	\N	INSERT on table ticket	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b289db	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a1cce5	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4b921c	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee2f75	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e60e7	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7cbcc3	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c778eb	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-812498	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-41ca1d	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a71f1e	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e2820a	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-85adca	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-070688	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2cda5b	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9980d9	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2535a5	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-173108	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8642f7	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-17ed82	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e843d	\N	INSERT on table ticket_convo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5908a1	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-81b13d	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d06da5	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-abc9c7	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c3a67e	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-31aaa4	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0d6430	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a26f76	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0c559b	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b472b	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e29cca	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-67bf1e	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa9b25	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1510cf	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-291bf6	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32895d	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad2bed	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4b5912	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-142bab	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-89d5e6	\N	INSERT on table campaign_contacts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-51adaf	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d06094	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-63a653	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6a90b	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-113a4a	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f43fcb	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2ce66e	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-73b2e9	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e1f9d7	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-83e80f	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fc570c	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f224b	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-43a569	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b6aa3	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-795c31	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f316d	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-792895	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c63508	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-03efd5	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e1059	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f345d	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a22a00	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7a046a	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a3ff69	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c200e9	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7aad0a	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-53a2c3	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0881af	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e8b340	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-acc2fb	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-62f15e	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2bfa2a	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a61937	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c5e18d	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9aeaae	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-601f81	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-325ceb	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e89b14	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-41f526	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db13f3	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-071bd5	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a66df6	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11e825	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-43c5a6	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b6e1b1	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-166598	\N	INSERT on table statement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-acfca5	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b25f00	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72ad0e	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a70608	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd9143	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-31eb11	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54c591	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4fad4b	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3e9d39	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-97ee31	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fb9f13	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-389dcb	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-799855	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e6c39	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bc5034	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad5585	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc67b6	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-044eec	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11691f	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-198c0a	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-522458	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-afe689	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-752677	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-673a41	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-390b15	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b7f41	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd9850	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6860b3	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f69752	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3ce9e1	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8073b0	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d91076	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c492e3	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a657a6	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-efb009	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6606c6	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2c1633	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9807b7	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6112b5	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-659b98	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a22c7	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cc331c	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c11c56	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d0bd8e	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eae7ab	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9a5f47	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-25ce21	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2df811	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6427ad	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2135c4	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-352595	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11ac40	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d88765	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1236de	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e15a61	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-61e623	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1ba209	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e316e1	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7869f4	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ca6f90	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ec3a75	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-52a46d	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ef240	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-456ff6	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-16062e	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4feea2	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28fa1f	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9bd400	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b21773	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-957874	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d94c96	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3cbee9	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d983f1	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19d671	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-88106c	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-51ce60	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc1267	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1086c2	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7c6a0a	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d088ad	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5bf5aa	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1cee0b	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7385c6	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-46badd	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7e657d	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-745b3e	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a15bbd	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-306d2c	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-578c4f	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-90a452	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0b3f83	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-02bd38	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f52884	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b83b5d	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1602c0	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0dd10	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b0300e	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-503877	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb9265	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-df659d	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-22638e	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3b43ff	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-39677f	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9397c1	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-45d167	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5d8b4	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3c6398	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-427963	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aaba7b	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1d211c	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0f6b51	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-613b07	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e00bac	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b49149	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9d6e9	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9fa696	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7b8fdc	\N	INSERT on table statement_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-abbf35	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b8819	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8ce8aa	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f5f789	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6ec8e1	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f4f7d	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7265c8	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7a468	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-17c81d	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7fbf65	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c3b7c	\N	INSERT on table quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e26232	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6cd622	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-71310e	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a36b6	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2bac40	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4527c3	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-91e700	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2a3227	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-794ece	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f8af9	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4784a0	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2f3af2	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-345ad0	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6638b8	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd12f3	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-265100	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5232a5	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b27b9	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1bc847	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea8648	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2f1ae	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d7afd4	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-05157d	\N	INSERT on table orders	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dea062	\N	INSERT on table non_project_order_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-74b938	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d55018	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6fcca5	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f4d83c	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cec515	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-77fdcb	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57fd8c	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-011d5c	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2999db	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5576c	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a8bed6	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-06a977	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-664d76	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4758e6	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2f1e5	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f9961	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-87ef6c	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32ff3d	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f6aee	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fe90d0	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-505f2f	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a986b0	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c90c12	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-336b32	\N	INSERT on table sales_invoices	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b9185	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e43abf	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1638df	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-97e925	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5b1f3	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb0216	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-21fb10	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7da831	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cc0b69	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8018f8	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b6cac4	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a7755e	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-78dd36	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e6e4d	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5267de	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0aae37	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-de2367	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fb8e4e	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e392e	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bd7198	\N	INSERT on table blanket_agreement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c1422e	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-204799	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-059205	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-66a53d	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-209587	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-76a6df	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-94459f	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4aa0bc	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e8934	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-298bb9	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4ecf9e	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d96577	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0f42c3	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0352eb	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bae3be	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f68ba	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-85d29b	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0bde5	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fbda8f	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-811b03	\N	INSERT on table service_call	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6df72d	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5c7297	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f2b258	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ce2285	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b2aac8	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-966295	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7a8103	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad5964	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-913de7	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ccfc3f	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a1926	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cbf6f2	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8771b6	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-889e0f	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-224484	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-55bac1	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-16b54e	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-440d66	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-774e8a	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-037330	\N	INSERT on table service_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-768f93	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b72cd	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-60ca57	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af9dd9	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eec776	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-24263c	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e92a10	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f2c2ea	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-12fa4d	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-619241	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dce55c	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54472e	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b3e40	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e64b88	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b85a0d	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a86b9e	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af622f	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4e3d58	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cf5081	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a23638	\N	INSERT on table service_analysis	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a7945b	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dd73d8	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4204b2	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-026925	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a0997a	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2379d8	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2f5775	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-36c15d	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6af65f	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b9d88c	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-77f46d	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-372d90	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c9346d	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b7852b	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fc10ff	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ef59e4	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2799d1	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e13bf3	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d353d8	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b9ee7	\N	INSERT on table after_analysis_sched	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7188c3	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-032890	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0294fa	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e4ebb3	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8294c3	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d741ec	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f7499e	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5fcd2	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-285588	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-792119	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c664b0	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cee73b	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-45940e	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b90a2a	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-992793	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5da93d	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-26f14e	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-58e11d	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7c7f0d	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f0f949	\N	INSERT on table service_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1afa4e	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db9e10	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1ca44b	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e4ac2	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-07a493	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-41d452	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1fa93c	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-24c62e	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-38a8ab	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea0325	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-780211	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e060a3	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-355e60	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b32fa1	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6c8f4f	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-23bc7c	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e23592	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4033b8	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6bd789	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-092080	\N	INSERT on table service_order_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ef9ba	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0b8885	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-da97e4	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-222755	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fde982	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72b7c4	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9897a0	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cbaf47	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b95a7a	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b720c5	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6da7b6	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a6f8e6	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-94916d	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f9142	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c8903e	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-397529	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b9b0f0	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-29aa26	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f3349	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0bd5e9	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2070df	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d060ac	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ab4783	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6a9666	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-251df9	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-daad10	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c2b66e	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f65904	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c4f5d8	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cf325d	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5c0395	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28e730	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-71b43e	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-94c185	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-934e16	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d7c89b	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d005d6	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-957f2c	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-811eca	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-86dc7d	\N	INSERT on table service_billing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e30e37	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d3a9dc	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19175c	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aac780	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8f0471	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa656f	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6beab7	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2d7f8	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7b3b49	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-45da8e	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ebf723	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dba7c7	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-79b28e	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f510b	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-459108	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bf8b0c	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c624ce	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-753e5e	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a8d3ef	\N	INSERT on table service_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0f26c3	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3b3758	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0bdfc4	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8234c4	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f6c17	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dd2d1f	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d24b3	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc9672	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cf3933	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7308b0	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-52e157	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-22ef77	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c2564	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-032a96	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a31cee	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cc5c9b	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6627cb	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-98c3f5	\N	INSERT on table service_contract	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-56257c	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-675738	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-16eae8	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-69c402	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6c8ed	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-20a90a	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b84260	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-99444c	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee75f8	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f2852	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7a7b54	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-67fcfd	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-142ab6	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d4ae96	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9ff65	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-776883	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1d5f07	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-76c0ce	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-201d9d	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-880e7f	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-259a5c	\N	INSERT on table additional_service	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4cac7b	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b194d0	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-15c796	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-18d86e	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f7e6aa	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9bffb	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c50a04	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a7a4f4	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-03f3cd	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-80095f	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b9e1c3	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-81c331	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-059ae8	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34f59a	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c2bf1d	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad73ae	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-82e83e	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-425642	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0bd89e	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8dc220	\N	INSERT on table additional_service_type	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b1251	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-00ae35	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-06bcf5	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-29775e	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-770dd9	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72b0a2	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-523761	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b3b971	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9cf3bd	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fb5c37	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ac557c	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-969efd	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c4e9f3	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bbdf55	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-49adb0	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-60d47a	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11d6b2	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5ed130	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7b0936	\N	INSERT on table departments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f3f13e	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c7ef12	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0db469	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aec44c	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d74c4c	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db72a2	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34e15e	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6719f9	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af3f2f	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-140aef	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-981cd3	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b3008	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a5d924	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-beae05	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28120e	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-043893	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c00821	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5a4894	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7a5767	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-93c54f	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-589771	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5f8f16	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9fd53	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0ddd15	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5a56ca	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5cc126	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f6057e	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f955b	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d8763c	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5519ee	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6d4a36	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e83e6a	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7ccfc6	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0589f9	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b2e3ce	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad824a	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a7c107	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f2d2b9	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4227a4	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c71ebc	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-60f593	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd070f	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c41917	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d4a60b	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f9a74b	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dca813	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-15c0cc	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8af0e5	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-712817	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f785da	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-176fbc	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2fd810	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-974f07	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7db7e	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7926da	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4bc16c	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-986615	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5969e	\N	INSERT on table positions	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a0dc9d	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-35754e	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3605b2	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e33db	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-937ec0	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-006de4	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e3db2	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f9a8bd	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7b6b39	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-058aac	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7d2b0	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b40a7	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eb6d5b	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-644ffe	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e28d81	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b7b880	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2a3ca	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-30527a	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9de9b0	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-52f452	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7c637e	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c0d8da	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ec3ed2	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-045022	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4dde0c	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-80faa1	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-90fd12	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6867d5	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5b4184	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-814d4c	\N	INSERT on table department_superiors	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34c962	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-686bfe	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-91d833	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57ef01	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a5674b	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6160aa	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0a80aa	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a459a9	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-845bb8	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-94aa85	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b41e3	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f05753	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7e94ae	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ba7fb6	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-37a51a	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e8c1d	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f991d9	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7f6de	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1dce2a	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ace1da	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cb0444	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd41be	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2d84e9	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-815c64	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-40a4fa	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5071b5	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4f271c	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aeb1fd	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0d22a6	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f556e4	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-718126	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-623d3c	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-515440	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48a87b	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db4ece	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-43886d	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8d0f48	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2be438	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a3fd3e	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-085c43	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ca669f	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-45ca89	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae0835	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee2330	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bce4ef	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0ef1b4	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-59d823	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5e1947	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cab5fa	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-09502d	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-35f554	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cc7409	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0966b2	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3812ea	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af191c	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ba8e31	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-111ef1	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d7917a	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8fea0b	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d2511	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b3f1c	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ce28e2	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-735fe0	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4778cd	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-103ec6	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f6ea2f	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-10d139	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-14079b	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f25188	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7fbfcd	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-098862	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28a801	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c4d853	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9a5fb7	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f2e67	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9abfcf	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-563319	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ced05c	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e8d61	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ef4237	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9dfcaa	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fc6183	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d71424	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b8e326	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-96647d	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-be8099	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7da7a1	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cad133	\N	INSERT on table employees	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f4b6ce	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-56725c	\N	INSERT on table users	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f212b2	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ffc3bf	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-66f255	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a86a5	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-33de46	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5d98c	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-910f9c	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c5be4c	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-683c74	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f0aafb	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-70c974	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0c4bad	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f88314	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f2324c	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-643744	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-702a04	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ab9153	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-327d44	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4389f4	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-31d3e9	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5bc35	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-542289	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fe9cc9	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c0da8e	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a1fbb	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5b41df	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3ba24b	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6833c0	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0f508	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f1a52	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f9fd12	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5c3e0	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a29ef6	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6de956	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-65bc84	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-14421f	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-528da6	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f2a11	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a81747	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5054ec	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e8e1e5	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e448e4	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a25919	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d8e687	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a1a8e	\N	INSERT on table calendar_dates	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a8003b	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cd0b7c	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7d7180	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6dacf6	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11a373	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3ddd2f	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5a93ed	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7bd48a	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-03dd7a	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f9d60f	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d3d87a	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4cc72e	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9c764d	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-178cd5	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-31cb02	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-983f30	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f5189	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-42be73	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2fc214	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-383928	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4b1d50	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5b6bd7	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4468ad	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aaa921	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54a42f	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-017975	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7bc44	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-205ce4	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72f62a	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-af59bc	\N	INSERT on table attendance_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-643c9b	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8c12f7	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-891d1c	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b105ff	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d4c7a8	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4ec8cd	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb5b1c	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6efed3	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-87098c	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e90116	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a033d2	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9644e	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c0bcf6	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0b490c	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f1645	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f8122b	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f53487	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0c7b8c	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-33b1c7	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b75c8a	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3b27d2	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b13fbe	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d8a901	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e58224	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a18223	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7ae298	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c6aab4	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-acd17b	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b8c85b	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e4939e	\N	INSERT on table employee_salary	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7cbadf	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b38cf2	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a6d2e3	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-240bab	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bf876b	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e2189c	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-26b4fa	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9510fd	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b2273	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a5349a	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f878ba	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cbec96	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa6469	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b06a4c	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-188a56	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8740a9	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f1e4b3	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-183022	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-988ac4	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-78bfe7	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48270d	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3636c6	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fb86d7	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1eb705	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9502df	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-06ab15	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a17ba	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6a998	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-192c87	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cbfb83	\N	INSERT on table employee_performance	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0ad21c	\N	INSERT on table employee_leave_balances	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-01971b	\N	INSERT on table employee_leave_balances	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-33fc59	\N	INSERT on table employee_leave_balances	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f7bbe8	\N	INSERT on table employee_leave_balances	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c671d	\N	INSERT on table leave_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-199dee	\N	INSERT on table leave_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-55c9d9	\N	INSERT on table payroll	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7ec546	\N	INSERT on table payroll	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-98ddcd	\N	INSERT on table payroll	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e274a	\N	INSERT on table workforce_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-56ee77	\N	INSERT on table workforce_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa371f	\N	INSERT on table workforce_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-82f2b1	\N	INSERT on table workforce_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ffb8c1	\N	INSERT on table workforce_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-477983	\N	INSERT on table job_posting	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e6eaf	\N	INSERT on table job_posting	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9b8e4	\N	INSERT on table job_posting	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a3d1e4	\N	INSERT on table job_posting	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d2d59	\N	INSERT on table job_posting	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-950d7a	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-216cd6	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-80d20f	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ce796c	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ca1a75	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-028fc0	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fb796b	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7c7eac	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ca7f80	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-124beb	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f0cf2	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-63b733	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-141661	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3a85e8	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-05e9d9	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1596f3	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2f8ad0	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f7401a	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8190a8	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7deea7	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d7cbf1	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5c6f9	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-575123	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d92eed	\N	INSERT on table policies	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9206b1	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2de51	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bde1b7	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b0108d	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ed3035	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-73f409	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-39c94e	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d5fe03	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-95a123	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3eb352	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b64303	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9dabd4	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a74b99	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f45e19	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3c5789	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c4cd39	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a793e1	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b26c5	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ccdfaa	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f94249	\N	INSERT on table warehouse	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-733e40	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-493404	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f1d007	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-793245	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a01ec7	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fe525b	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e67d4b	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae0fbc	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1acba3	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-be8871	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5d017	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-22e749	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-591d39	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a16351	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f93e4	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bd0930	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-617db3	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d4bf3c	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5b38c9	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8796d5	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0d1e6	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1248ab	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7b3178	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2e463d	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-808b23	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3a64ea	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4776b9	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48c267	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-90e0a6	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5789b	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bc0278	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-edd836	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-be5e07	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7ac724	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9494d9	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ed1fca	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-11013e	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a1dbd1	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3e2011	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9789c6	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-46b9c5	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2ea4bc	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-63e33f	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1017d0	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e3196	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-373b2d	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a4843b	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7e4c7c	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d060c6	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0db0ec	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-47abf8	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-99ce55	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d56212	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cabd53	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-099b01	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-198d17	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-056571	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b95c01	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-add71a	\N	INSERT on table roles_permission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c6ed71	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cdc388	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fffef4	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fb4ed6	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fafae8	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-deea71	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d47499	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e2ce78	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2026c5	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-23a8f1	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6639a0	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0591fa	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-293e6b	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8012d2	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-874fe8	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-550c41	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db3319	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5c231e	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b09bf1	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f1efe2	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3966ae	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-75ae51	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9d9fb4	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e736bd	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d919a9	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-047fe8	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dc5004	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-59529d	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f0c51a	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f84c26	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0e5d73	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c7084a	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e45314	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a1af32	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4ea098	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fba24b	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0452e0	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a4837f	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e3dcb4	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-006bf8	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae4492	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6ce044	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8bb6f1	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-64f697	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-217ba9	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e50970	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cf78e2	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54d3da	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e82e9	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-234092	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-92712b	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c7d8af	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e44bf4	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d9dd7b	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-afbc4d	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f752c	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-232dd5	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6ae40d	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5eca82	\N	INSERT on table raw_materials	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f37aca	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-deff74	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5148e5	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee7f89	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b0622c	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-42998f	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-df04a4	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cf03a6	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-551a2c	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b42cf8	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b3c137	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7d654	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e46dff	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54471e	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d23736	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5eba21	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f03c16	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e2402	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-096700	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b2ecb	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1dc547	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8945f9	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a4d2a8	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-287c19	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7aa78f	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-51cf8f	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-471d05	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5f6bd5	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dda7ae	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48aaf7	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-da4859	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-967b25	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e96e2b	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a79f76	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a3770f	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-db7428	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-516529	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-410011	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-deaa9a	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-806669	\N	INSERT on table assets	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d3c7ec	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-de0c13	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-39d542	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-89a876	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4d06a0	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-393b53	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-60d666	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-69af3d	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b2fba1	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d2ced	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2e8ecf	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-37ab58	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e089ae	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-256b3d	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8e3ee9	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e9cfe0	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b69dd5	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-15d11a	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cc2817	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d26a04	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6224f6	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4fea17	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5373c9	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3fcc11	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-590e61	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4483c9	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-769847	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b37c70	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb8f4c	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2c76ac	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea9af0	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-442cca	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a80a30	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-342685	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3cc14b	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-17da2e	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f575d5	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-76387f	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6fe2c7	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1235a4	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e63f4	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e64bba	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6446e0	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d247ca	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cfe1fd	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c7a99d	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e036c4	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d1f0f1	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6ab40b	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e256c2	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e1454f	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-624a62	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-817fa1	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f893f2	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e06d42	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2bd12e	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ebf7ee	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-65a1d4	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0c4241	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b184d	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-01e6a0	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1433f5	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a520e6	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c5ae47	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f173f2	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee222d	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad10d3	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-39b40d	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-289c14	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4d7b0e	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e2ac05	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-323503	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b1386b	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d7309	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8784fb	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b99dd4	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ada355	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-814e19	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-37ce72	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8d8de2	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b864ac	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dfcdc5	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a19ae5	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-45deb7	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ef8a07	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee6d20	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-08e2e9	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f07e60	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7c253f	\N	INSERT on table products	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7e6f80	\N	INSERT on table item_master_data	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4aff0e	\N	INSERT on table product_pricing	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dbaf75	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-904bc7	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b50cf1	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7c65a3	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-25c6ed	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d9838	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2240ab	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d49feb	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f95c88	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-38c0c3	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-38d201	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a205d	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-50db3a	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c0073e	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f552f8	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5babff	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2795d7	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b0e34	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9cef4b	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7240d7	\N	INSERT on table currency	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7dfa59	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-865420	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1f5fc3	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-23c873	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-43e087	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-67fc96	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-97d043	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b8a39	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-aea8f0	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1d7d40	\N	INSERT on table management_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e4937a	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4ed335	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bec326	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d58722	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-df5117	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-51007c	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b6a4b3	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b12060	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b71c1	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bf5764	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-45a730	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d83cc	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1e1317	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b04b5f	\N	INSERT on table budget_allocation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ccc878	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c65b4d	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b0d74a	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9d3214	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea140f	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f0d66	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6dd0a5	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d9a611	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-59db64	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6e7aff	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-28fd06	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b9e062	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3541a2	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1850aa	\N	INSERT on table budget_submission	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e4bb47	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-125ee1	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ab2151	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8874d1	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-38b3e5	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5478e5	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-101017	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a34818	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-23f447	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dcdb7b	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-552afe	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-29ee7e	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d520c9	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0f21a	\N	INSERT on table budget_request_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-205d19	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a832e	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f72075	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-331f4f	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57cedc	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-201a07	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-92f90f	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1030c7	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4bf974	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b0c2ed	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-03e288	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-347936	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d1fa84	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-736b8a	\N	INSERT on table budget_returns_form	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9f4b24	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3e57c1	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ffa3c4	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f5710e	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f94eed	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b2998	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-059417	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ae735	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a4e596	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ca8d0c	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7cd740	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-93cf86	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cdaa4e	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-111b1e	\N	INSERT on table budget_validations	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3ed0ca	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8d963c	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a29bf4	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5932bc	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0d3c97	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-57d69c	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7157bc	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9bb459	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-933f08	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ce27a	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-27766b	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d8b096	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2e1408	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-de4e53	\N	INSERT on table budget_approvals	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2abb72	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3e67ba	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d86392	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1eb474	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3f0391	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eb17ad	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bcb695	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72f6f5	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-16a58b	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-489439	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72d1d9	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-caecd1	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1918f2	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-71a311	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b0dd51	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-75c28e	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-274776	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-87549c	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5a6bc3	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-888bc8	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-132e2a	\N	INSERT on table document_header	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa65bc	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-94da31	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1bc2c7	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-adfebe	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72c4fc	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2309c5	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a7d13c	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-907c98	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d56297	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee5375	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-863aa8	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-daa3f5	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-33f493	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f38e09	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-82f43e	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-feb3b4	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4dcc2c	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2166f9	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6b988c	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d9baff	\N	INSERT on table serial_tracking	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-73a9bc	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7841a0	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34671c	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-43e6d1	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b03250	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e5799e	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f4a0b	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-825721	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3d45fb	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cebd03	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-55af1b	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c0087b	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-73e6ad	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-765788	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2297f1	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-afcd66	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-78a785	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d505bc	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0fdaee	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-51a7c5	\N	INSERT on table product_document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3ced07	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ec3472	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3cf69e	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-75322a	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9619f1	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5503ff	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-825c99	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-18cf77	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-13c0e9	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3a3e59	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-658dda	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1b4b34	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d42711	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0faf7f	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9be19e	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8de3b2	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c0477e	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ff7d7b	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2669cf	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-df4e90	\N	INSERT on table document_items	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7bb06d	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-68972d	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7228d0	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-85d49a	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-49dee6	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dd988d	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d73bf4	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ff5e7	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-64de44	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b72bfc	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-df28b4	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7c7b21	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-74908d	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-29661c	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bc200a	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fa46bf	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-03e71f	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f0b646	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-da7892	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-743508	\N	INSERT on table external_module	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5ebe00	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-54ad84	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a637ea	\N	INSERT on table vendor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-107215	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7eccb4	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d07a44	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6d983a	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-49e2ec	\N	INSERT on table vendor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ebb36d	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-395b76	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7d74f4	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-421a06	\N	INSERT on table vendor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb23d2	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f5e208	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-17aef6	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-924881	\N	INSERT on table vendor_application	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a9938b	\N	INSERT on table vendor	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-314be7	\N	INSERT on table business_partner_master	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-87697c	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f7ba6c	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1df88e	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c3147a	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8f7d96	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b25b99	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a85744	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bd6ecf	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-451056	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-92a2db	\N	INSERT on table purchase_requests	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4b7b8a	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-15b91d	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-92d240	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f96fec	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-941767	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0dd562	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c6bf2a	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b2fbef	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-93c707	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ed75f5	\N	INSERT on table quotation_contents	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9b0daf	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3cd16c	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-465d62	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4a47c8	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b3cede	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-022fc0	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5b6f5d	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-23a255	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48c11a	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8fdcb3	\N	INSERT on table purchase_quotation	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-df7451	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0657b8	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e2c8f5	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6aa755	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-36fe5a	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c57bc6	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b6d2d	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cae1c2	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-085e3b	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1435d2	\N	INSERT on table purchase_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8b377a	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cbf9bc	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6fd1bf	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b7f88	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-08157d	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e2d011	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0f700c	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-851423	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-320c60	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1c4575	\N	INSERT on table purchase_invoice	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d2b769	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d633b0	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4feb73	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8c77ca	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6699ba	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fc3b71	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-364c9a	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6645c8	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-405f8c	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cbc86a	\N	INSERT on table received_shipments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7037e4	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b4e3fb	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-66d5ed	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d430a2	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7a735	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-148070	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-323030	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cfb97d	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5bd225	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c27bf0	\N	INSERT on table batch_inspection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-acd9b8	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0fd3b6	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d6120	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-76341d	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-373678	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ca3008	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-150389	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-775c55	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-36244d	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9d9f55	\N	INSERT on table credit_memo	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5437af	\N	INSERT on table inventory_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6f4613	\N	INSERT on table inventory_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fbe018	\N	INSERT on table inventory_item	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ee3fdd	\N	INSERT on table inventory_cyclic_counts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3413a9	\N	INSERT on table inventory_cyclic_counts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ccfab0	\N	INSERT on table inventory_cyclic_counts	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2c8dec	\N	INSERT on table inventory_adjustments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d07b34	\N	INSERT on table inventory_adjustments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d998b4	\N	INSERT on table inventory_adjustments	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e88dc4	\N	INSERT on table deprecation_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a463c8	\N	INSERT on table deprecation_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ec06be	\N	INSERT on table deprecation_report	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a986ab	\N	INSERT on table warehouse_movement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c6e70d	\N	INSERT on table warehouse_movement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ad8c0	\N	INSERT on table warehouse_movement	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34513e	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-284840	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-07d704	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9c577a	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ac3547	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b3346	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e7b53d	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72d9c2	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b539f4	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-214c3f	\N	INSERT on table carrier	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-862e0c	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-70fc97	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-38df1c	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4e971e	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb73ab	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-71c1be	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-254cdf	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b5d7ed	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-da641b	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-50ac33	\N	INSERT on table packing_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b9da9f	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-969159	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-303b12	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-712ae6	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fc6518	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-fc1cf3	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cab5bc	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d13653	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3c80cf	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-25efc2	\N	INSERT on table logistics_approval_request	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-321d1d	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c77b07	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-377076	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-013de3	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a72e7c	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48c3ae	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4c305b	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ebaadd	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4e2988	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-459e0d	\N	INSERT on table delivery_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-32663f	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d060a6	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2b1fd9	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34393d	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-994641	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f543a1	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-31759b	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-532594	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ad7423	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-73df51	\N	INSERT on table picking_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7217fd	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-68a49e	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d0a730	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e04975	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7b4471	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a1d2f1	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0f8a58	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-780da3	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0cabfa	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-68347e	\N	INSERT on table packing_list	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6a1116	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-4f0c78	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a508e9	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dd5491	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-b876f8	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-72cbec	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-408411	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-07c9c9	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ed2886	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-2ac054	\N	INSERT on table shipping_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a9a66d	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d650d7	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-95c734	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9659c0	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-dbc48b	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-331025	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-014c9f	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-c27907	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-83340f	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-173930	\N	INSERT on table operational_cost	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-267b64	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9d9aba	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-05e02e	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f2ac23	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d35c14	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-66b4a1	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-543c02	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-faf898	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9e448a	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a95ba	\N	INSERT on table failed_shipment	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-49e8b7	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-90e0a9	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-942e7b	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f6172	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f6aa1	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9ec931	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-969d7c	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1a2231	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-225026	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-87cba2	\N	INSERT on table shipment_details	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-01437f	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d0f0fd	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-666e67	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-462b57	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d26975	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-886257	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-eb9a57	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-087354	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-132987	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f54744	\N	INSERT on table delivery_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e6c413	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ac3136	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-1908dc	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-52548d	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6929eb	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-5d047d	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-cb7928	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-19ebfa	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-34bc5c	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-64c02d	\N	INSERT on table rejection	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-136f59	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-421d76	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ae8998	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3ee4bc	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a14f80	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8a8d90	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-8ffb26	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ea5630	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9313d8	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7fa11a	\N	INSERT on table rework_order	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-6d9c9d	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-20d13c	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-ca04c2	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-58cb45	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e3eb20	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-3b58e0	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-0c63fa	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-74f5f5	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-f19e1b	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a5d72b	\N	INSERT on table billing_receipt	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-bb478e	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-a2d546	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-d7123a	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-51241f	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-7f57a8	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-48e50a	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-626636	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-e0f8f8	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-984f66	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
ADMIN-LOG-2025-9cf85b	\N	INSERT on table goods_issue	2025-04-11 23:12:09.071108	::1/128
\.


--
-- Data for Name: business_partner_master; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.business_partner_master (partner_id, employee_id, vendor_code, customer_id, partner_name, category, contact_info) FROM stdin;
ADMIN-PARTNER-2025-d56504	\N	\N	SALES-CUST-2025-11c3dc	St. Luke's Medical Center	Customer	+63-2-8723-0101
ADMIN-PARTNER-2025-4d55e0	\N	\N	SALES-CUST-2025-581de7	Makati Medical Center	Customer	+63-2-8888-9999
ADMIN-PARTNER-2025-d121cb	\N	\N	SALES-CUST-2025-ee8185	The Medical City	Customer	+63-2-8639-2000
ADMIN-PARTNER-2025-6e61fa	\N	\N	SALES-CUST-2025-a06fff	Asian Hospital and Medical Center	Customer	+63-2-8771-9000
ADMIN-PARTNER-2025-3de538	\N	\N	SALES-CUST-2025-303e3d	Philippine General Hospital	Customer	+63-2-8554-8400
ADMIN-PARTNER-2025-77a757	\N	\N	SALES-CUST-2025-e3832a	Manila Doctors Hospital	Customer	+63-2-8558-0888
ADMIN-PARTNER-2025-907d9c	\N	\N	SALES-CUST-2025-bfc826	Cardinal Santos Medical Center	Customer	+63-2-8727-0001
ADMIN-PARTNER-2025-4fb929	\N	\N	SALES-CUST-2025-920ea7	World Citi Medical Center	Customer	+63-2-8913-8380
ADMIN-PARTNER-2025-ddeeeb	\N	\N	SALES-CUST-2025-96421d	Davao Doctors Hospital	Customer	+63-82-222-8000
ADMIN-PARTNER-2025-9f7334	\N	\N	SALES-CUST-2025-16f160	Cebu Doctors University Hospital	Customer	+63-32-255-5555
ADMIN-PARTNER-2025-5cc8c8	\N	\N	SALES-CUST-2025-1ced77	Metro Manila Medical Center	Customer	+63-2-8711-4141
ADMIN-PARTNER-2025-c9c2a8	\N	\N	SALES-CUST-2025-393e34	East Avenue Medical Center	Customer	+63-2-8928-0611
ADMIN-PARTNER-2025-39ba33	\N	\N	SALES-CUST-2025-11316f	Capitol Medical Center	Customer	+63-2-8372-3825
ADMIN-PARTNER-2025-454ada	\N	\N	SALES-CUST-2025-461682	Ospital ng Makati	Customer	+63-2-8828-8443
ADMIN-PARTNER-2025-611e15	\N	\N	SALES-CUST-2025-5ed6e4	Lung Center of the Philippines	Customer	+63-2-8924-6101
ADMIN-PARTNER-2025-cacb02	\N	\N	SALES-CUST-2025-a5e198	National Kidney and Transplant Institute	Customer	+63-2-8981-0300
ADMIN-PARTNER-2025-dc9342	\N	\N	SALES-CUST-2025-a1283c	Rizal Medical Center	Customer	+63-2-8941-2911
ADMIN-PARTNER-2025-4cd806	\N	\N	SALES-CUST-2025-a53d8e	Quirino Memorial Medical Center	Customer	+63-2-8913-7890
ADMIN-PARTNER-2025-4fe472	\N	\N	SALES-CUST-2025-e1bf4f	Jose R. Reyes Memorial Medical Center	Customer	+63-2-8731-3229
ADMIN-PARTNER-2025-f45c1c	\N	\N	SALES-CUST-2025-6f4365	Perpetual Help Medical Center	Customer	+63-2-8871-0639
ADMIN-PARTNER-2025-17edf5	E001	\N	\N	Kate Tan	Employee	09165824756
ADMIN-PARTNER-2025-c3bbd6	E048	\N	\N	Camille Rivera	Employee	09341234567
ADMIN-PARTNER-2025-0b92e0	E150	\N	\N	Francis Lim	Employee	09678901236
ADMIN-PARTNER-2025-0398ac	E010	\N	\N	Karen Mendoza	Employee	09139485762
ADMIN-PARTNER-2025-2ae112	E019	\N	\N	Juan Dela Cruz	Employee	09123456789
ADMIN-PARTNER-2025-fbd433	E120	\N	\N	Aaron Dela Cruz	Employee	09171234561
ADMIN-PARTNER-2025-e11356	E133	\N	\N	Madison Ferrer	Employee	09171234573
ADMIN-PARTNER-2025-8964fa	E167	\N	\N	Adrian Cruz	Employee	09171234590
ADMIN-PARTNER-2025-cc74ef	E002	\N	\N	James Marticio	Employee	09123456789
ADMIN-PARTNER-2025-ae948e	E004	\N	\N	Maria Lopez	Employee	09154321876
ADMIN-PARTNER-2025-ea460b	E178	\N	\N	Angelo Santos	Employee	09171234567
ADMIN-PARTNER-2025-31e10f	E179	\N	\N	Maria Dela Cruz	Employee	09281234567
ADMIN-PARTNER-2025-27cbe6	E180	\N	\N	Joseph Reyes	Employee	09391234567
ADMIN-PARTNER-2025-d58ab4	E181	\N	\N	Katrina Villanueva	Employee	09451234567
ADMIN-PARTNER-2025-519c3b	E182	\N	\N	Mark Buenaventura	Employee	09561234567
ADMIN-PARTNER-2025-3fc488	E183	\N	\N	Luis Mendoza	Employee	09171234601
ADMIN-PARTNER-2025-2dfb67	E184	\N	\N	Maria Santos	Employee	09171234602
ADMIN-PARTNER-2025-77142d	E185	\N	\N	Nico Perez	Employee	09171234603
ADMIN-PARTNER-2025-ddd0ef	E186	\N	\N	Olivia Tan	Employee	09171234604
ADMIN-PARTNER-2025-66b9b6	E187	\N	\N	Paolo Aguila	Employee	09171234605
ADMIN-PARTNER-2025-28514f	E188	\N	\N	Andrea Gomez	Employee	09671234567
ADMIN-PARTNER-2025-d969bb	E189	\N	\N	Christian Mendoza	Employee	09781234567
ADMIN-PARTNER-2025-ef7f89	E190	\N	\N	Patricia Lim	Employee	09891234567
ADMIN-PARTNER-2025-b19607	E191	\N	\N	Daniel Ramos	Employee	09951234567
ADMIN-PARTNER-2025-940010	E192	\N	\N	Sofia Navarro	Employee	09181234567
ADMIN-PARTNER-2025-35e2e6	E193	\N	\N	Quentin Soriano	Employee	09171234606
ADMIN-PARTNER-2025-9bc96c	E194	\N	\N	Rhea Mendoza	Employee	09171234607
ADMIN-PARTNER-2025-2f9427	E195	\N	\N	Simon Reyes	Employee	09171234608
ADMIN-PARTNER-2025-3f6e85	E196	\N	\N	Tanya Alonzo	Employee	09171234609
ADMIN-PARTNER-2025-527299	E197	\N	\N	Victor Castro	Employee	09171234610
ADMIN-PARTNER-2025-629a10	\N	ADMIN-VENDOR-2025-6df215	\N	Beta Materials	Vendor	Jane Smith
ADMIN-PARTNER-2025-3f85a4	\N	ADMIN-VENDOR-2025-9b80dd	\N	Epsilon Tools	Vendor	Charlie White
ADMIN-PARTNER-2025-c38635	\N	ADMIN-VENDOR-2025-1e68b8	\N	Eta Chemicals	Vendor	Edward Gray
ADMIN-PARTNER-2025-5bb8be	\N	ADMIN-VENDOR-2025-062773	\N	Kappa Textiles	Vendor	Helen Blue
\.


--
-- Data for Name: currency; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.currency (currency_id, currency_name, exchange_rate, valid_from, valid_to) FROM stdin;
ADMIN-CUR-2025-c0fda7	Philippine Peso	1.000000	2025-04-11	\N
ADMIN-CUR-2025-15faf7	US Dollar	0.017500	2025-04-11	\N
ADMIN-CUR-2025-5ed294	Euro	0.016260	2025-04-11	\N
ADMIN-CUR-2025-9b7704	British Pound	0.013930	2025-04-11	\N
ADMIN-CUR-2025-f1ab06	Japanese Yen	0.002650	2025-04-11	\N
ADMIN-CUR-2025-2f1f5a	Canadian Dollar	0.023940	2025-04-11	\N
ADMIN-CUR-2025-ff9970	Australian Dollar	0.026380	2025-04-11	\N
ADMIN-CUR-2025-97eb38	Swiss Franc	0.015570	2025-04-11	\N
ADMIN-CUR-2025-d42cf2	Chinese Yuan	0.127400	2025-04-11	\N
ADMIN-CUR-2025-fdc0a8	Hong Kong Dollar	0.128500	2025-04-11	\N
ADMIN-CUR-2025-c7d1c2	Singapore Dollar	0.023740	2025-04-11	\N
ADMIN-CUR-2025-d8e871	South Korean Won	0.000750	2025-04-11	\N
ADMIN-CUR-2025-ee0fd2	United Arab Emirates Dirham	0.004760	2025-04-11	\N
ADMIN-CUR-2025-d3f29e	Saudi Riyal	0.004690	2025-04-11	\N
ADMIN-CUR-2025-5d551f	Thai Baht	0.027820	2025-04-11	\N
ADMIN-CUR-2025-89ed82	Vietnamese Dong	0.000044	2025-04-11	\N
ADMIN-CUR-2025-7753a5	Indonesian Rupiah	0.000064	2025-04-11	\N
ADMIN-CUR-2025-9763d7	Indian Rupee	0.013500	2025-04-11	\N
ADMIN-CUR-2025-c2cdaf	Malaysian Ringgit	0.023400	2025-04-11	\N
ADMIN-CUR-2025-0ea20a	New Zealand Dollar	0.028800	2025-04-11	\N
\.


--
-- Data for Name: item_master_data; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.item_master_data (item_id, asset_id, product_id, material_id, item_name, item_type, unit_of_measure, item_status, manage_item_by, preferred_vendor, purchasing_uom, items_per_purchase_unit, purchase_quantity_per_package, sales_uom, items_per_sale_unit, sales_quantity_per_package) FROM stdin;
ADMIN-ITEM-2025-1c8e62	\N	\N	ADMIN-MATERIAL-2025-0f17fa	AI Driven Electronics Component	Raw Material	set	Active	None	\N	set	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-25c84c	\N	\N	ADMIN-MATERIAL-2025-ef3fda	Casing	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-5a0057	\N	\N	ADMIN-MATERIAL-2025-ed320b	Chambers	Raw Material	unit	Active	None	\N	unit	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-86c7d3	\N	\N	ADMIN-MATERIAL-2025-b7f4a5	Clamps	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-89ff4c	\N	\N	ADMIN-MATERIAL-2025-24fcc5	Coatings	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-b99734	\N	\N	ADMIN-MATERIAL-2025-5ebcb4	Heating and Drying System	Raw Material	unit	Active	None	\N	unit	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-8e18d8	\N	\N	ADMIN-MATERIAL-2025-ba8edd	Polycarbonate	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-834217	\N	\N	ADMIN-MATERIAL-2025-7da3cc	Polyethylene	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-fbddef	\N	\N	ADMIN-MATERIAL-2025-77527a	Power System	Raw Material	unit	Active	None	\N	unit	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-d21f75	\N	\N	ADMIN-MATERIAL-2025-464b29	Pump	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-094e52	\N	\N	ADMIN-MATERIAL-2025-16ca99	Purification Media	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-0c6142	\N	\N	ADMIN-MATERIAL-2025-868c8b	Sensors	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-5297fb	\N	\N	ADMIN-MATERIAL-2025-5febb4	Structural Frame & Casing	Raw Material	set	Active	None	\N	set	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-fe73cc	\N	\N	ADMIN-MATERIAL-2025-ced2d3	Suction	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-c0d16f	\N	\N	ADMIN-MATERIAL-2025-5f28a9	Ultrasound Transducer	Raw Material	unit	Active	None	\N	unit	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-6aefdb	\N	\N	ADMIN-MATERIAL-2025-9bc91c	Acrylic	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-1044c1	\N	\N	ADMIN-MATERIAL-2025-266ce4	Acrylonitrile Butadiene Styrene (ABS)	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-6df2fd	\N	\N	ADMIN-MATERIAL-2025-2d9cc3	Airflow Components	Raw Material	set	Active	None	\N	set	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-b31bac	\N	\N	ADMIN-MATERIAL-2025-ffa6b9	Aluminum	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-27a065	\N	\N	ADMIN-MATERIAL-2025-c2c12c	Aluminum Alloys	Raw Material	set	Active	None	\N	set	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-dcf23c	\N	\N	ADMIN-MATERIAL-2025-c8460b	Anesthetic Delivery System	Raw Material	set	Active	None	\N	set	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-44004a	\N	\N	ADMIN-MATERIAL-2025-3c891b	Bacterial Filters	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-13e632	\N	\N	ADMIN-MATERIAL-2025-2c7851	Battery	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-2724df	\N	\N	ADMIN-MATERIAL-2025-27843d	Borosilicate Glass	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-4c4ce4	\N	\N	ADMIN-MATERIAL-2025-1ab9e9	Buffering Agent	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-fd9ab1	\N	\N	ADMIN-MATERIAL-2025-3b1a5d	Buttons	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-e3df20	\N	\N	ADMIN-MATERIAL-2025-4fcfb8	Cables	Raw Material	mm	Active	None	\N	mm	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-445033	\N	\N	ADMIN-MATERIAL-2025-2a9a62	Canister Body	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-552137	\N	\N	ADMIN-MATERIAL-2025-387b6f	Capacitors	Raw Material	pcs	Active	None	\N	pcs	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-3a2326	\N	\N	ADMIN-MATERIAL-2025-1c4bc2	Capnography Sensor	Raw Material	kg	Active	None	\N	kg	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-90e1e5	ADMIN-ASSET-2025-d4eb59	\N	\N	Laptop - Dell XPS 15	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-e80cd0	ADMIN-ASSET-2025-204a43	\N	\N	Office Chair - Ergonomic	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-ca17ea	ADMIN-ASSET-2025-5c3f34	\N	\N	Printer - HP LaserJet Pro	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-caa37a	ADMIN-ASSET-2025-1f8b05	\N	\N	Projector - Epson X500	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-cbf153	ADMIN-ASSET-2025-ce1097	\N	\N	Desk - Wooden Executive	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-7d5b2a	ADMIN-ASSET-2025-108036	\N	\N	Monitor - LG UltraWide	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-30f586	ADMIN-ASSET-2025-692d29	\N	\N	Keyboard - Mechanical RGB	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-04eddf	ADMIN-ASSET-2025-d2098f	\N	\N	Mouse - Logitech MX Master 3	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-b792b8	ADMIN-ASSET-2025-86767d	\N	\N	External Hard Drive - 2TB	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-129fb3	ADMIN-ASSET-2025-4a2f1b	\N	\N	Conference Speaker - Jabra Speak 750	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-5d5f9b	ADMIN-ASSET-2025-d78933	\N	\N	Tablet - iPad Pro	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-eee18d	ADMIN-ASSET-2025-01845b	\N	\N	Smartphone - Samsung Galaxy S24	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-52b188	ADMIN-ASSET-2025-b3cebd	\N	\N	Scanner - Canon imageFORMULA	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-392993	ADMIN-ASSET-2025-391078	\N	\N	Router - Cisco RV340	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-bc281f	ADMIN-ASSET-2025-bc0967	\N	\N	Filing Cabinet - Steel 4-Drawer	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-d2b0b9	ADMIN-ASSET-2025-104f69	\N	\N	Webcam - Logitech Brio	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-8f5393	ADMIN-ASSET-2025-08abb3	\N	\N	Whiteboard - Magnetic	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-09c62a	ADMIN-ASSET-2025-54466a	\N	\N	Speaker System - Bose Companion	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-5d25e9	ADMIN-ASSET-2025-d52f63	\N	\N	UPS - APC Smart-UPS	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-d1ebf0	ADMIN-ASSET-2025-148daa	\N	\N	Air Purifier - Dyson Pure Cool	Asset	\N	Active	Serial Number	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-f7160a	\N	ADMIN-PROD-2025-fe6c97	\N	A9	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-09b913	\N	ADMIN-PROD-2025-319fae	\N	AirStart10	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-3e039a	\N	ADMIN-PROD-2025-9c8bbf	\N	B2 Infant Incubator	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-c137df	\N	ADMIN-PROD-2025-f1ad06	\N	B3 Neonatal Incubator	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-479446	\N	ADMIN-PROD-2025-52bf2a	\N	B8/B6 Neonatal Incubator	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-b01214	\N	ADMIN-PROD-2025-b44bc9	\N	BeneFusion 5 Series	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-fdbef3	\N	ADMIN-PROD-2025-7871b8	\N	BeneFusion e Series	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-e6e9e7	\N	ADMIN-PROD-2025-aa1c8e	\N	BeneFusion n Series	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-1289bd	\N	ADMIN-PROD-2025-3f12a8	\N	BeneHeart AED C2 and D1 PRO	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-765412	\N	ADMIN-PROD-2025-8e1a8d	\N	BeneHeart D3	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-dbd66f	\N	ADMIN-PROD-2025-1dc59b	\N	BeneHeart D6	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-5359c1	\N	ADMIN-PROD-2025-aa456d	\N	BeneHeart R12	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-a9390c	\N	ADMIN-PROD-2025-abca9c	\N	BeneHeart R3	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-fa49b8	\N	ADMIN-PROD-2025-5e90b5	\N	BeneVision CMS	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-0fbf60	\N	ADMIN-PROD-2025-b61a90	\N	BeneVision N Series	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-961df5	\N	ADMIN-PROD-2025-44afc4	\N	BeneVision N1	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-bbe1c4	\N	ADMIN-PROD-2025-18b0e8	\N	BL70 Infant Phototherapy Equipment	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-96e15d	\N	ADMIN-PROD-2025-67e15f	\N	BQ80 Infant Radiant Warmer	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-49c165	\N	ADMIN-PROD-2025-93b1cb	\N	EMMA Capnograph	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-8daed0	\N	ADMIN-PROD-2025-5db948	\N	ePM Series	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-414636	\N	ADMIN-PROD-2025-2aa802	\N	HyBase 3000	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-1baccc	\N	ADMIN-PROD-2025-b42e3f	\N	HyBase 6100/6100 PLUS	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-bbdf3d	\N	ADMIN-PROD-2025-9e5700	\N	HyBase V8/V8 Classic	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-1121f6	\N	ADMIN-PROD-2025-0aee27	\N	HyBase V9	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-80febe	\N	ADMIN-PROD-2025-b5978f	\N	HyLED 200 M	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-71b42c	\N	ADMIN-PROD-2025-f57a52	\N	HyLED 600	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-b441d9	\N	ADMIN-PROD-2025-dbe3ca	\N	HyLED 600M	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-36faed	\N	ADMIN-PROD-2025-ca38e5	\N	HyLED 7 Series	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-2eef14	\N	ADMIN-PROD-2025-7a2c68	\N	HyLED 760	Product	set	Active	Batches	\N	\N	\N	\N	\N	\N	\N
ADMIN-ITEM-2025-b59250	\N	ADMIN-PROD-2025-e891e0	\N	HyLED 760M	Product	pcs	Active	Batches	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.notifications (notifications_id, module, to_user_id, message, notifications_status, created_at) FROM stdin;
\.


--
-- Data for Name: policies; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.policies (policy_id, policy_name, description, effective_date, status) FROM stdin;
ADMIN-POLICY-2025-b6245e	Equal Employment Opportunity	Ensures fair treatment and prohibits discrimination in the workplace.	2025-04-11	Active
ADMIN-POLICY-2025-574f3e	Policy Against Workplace Harassment	Prohibits harassment and provides reporting and resolution procedures.	2025-04-11	Active
ADMIN-POLICY-2025-bb9191	Hiring and Onboarding Procedures	Details the recruitment, hiring, and onboarding process.	2025-04-11	Active
ADMIN-POLICY-2025-2bcdf3	Hours of Work, Attendance, and Punctuality	Establishes work schedules and attendance requirements.	2025-04-11	Active
ADMIN-POLICY-2025-fa5165	Overtime Policy	Outlines overtime compensation for eligible employees.	2025-04-11	Active
ADMIN-POLICY-2025-9ddf0b	Position Description and Salary Administration	Defines job descriptions, salary ranges, and pay schedules.	2025-04-11	Active
ADMIN-POLICY-2025-6638fb	Health/Life Insurance Policy	Provides individual health and dental insurance for eligible employees.	2025-04-11	Active
ADMIN-POLICY-2025-cca9f7	Retirement and Tax Deferred Annuity Plan	Outlines employee retirement benefits and annuity options.	2025-04-11	Active
ADMIN-POLICY-2025-27ceb9	Leave Benefits Policy	Details vacation, sick leave, personal, bereavement, and extended leave benefits.	2025-04-11	Active
ADMIN-POLICY-2025-961f69	Maternity and Paternity Leave Policy	Provides guidelines for maternity, paternity, and parental leave.	2025-04-11	Active
ADMIN-POLICY-2025-640d68	Separation Policy	Outlines the process for resignation, termination, and layoffs.	2025-04-11	Active
ADMIN-POLICY-2025-f32613	Return of Property Policy	Requires employees to return company property upon separation.	2025-04-11	Active
ADMIN-POLICY-2025-e2158e	Personnel Records Policy	Governs the maintenance and confidentiality of personnel records.	2025-04-11	Active
ADMIN-POLICY-2025-fdd56b	Non-Disclosure of Confidential Information	Protects confidential company and customer information.	2025-04-11	Active
ADMIN-POLICY-2025-feb303	Computer and Information Security	Defines IT security protocols for system and data protection.	2025-04-11	Active
ADMIN-POLICY-2025-029c59	Internet Acceptable Use Policy	Regulates internet use to ensure compliance and professionalism.	2025-04-11	Active
ADMIN-POLICY-2025-204ab1	Accounting Standards Policy	Adheres to GAAP or IFRS for financial reporting.	2025-04-11	Active
ADMIN-POLICY-2025-13fb42	Detailed Accounting Procedures	Outlines financial controls including petty cash and fund disbursements.	2025-04-11	Active
ADMIN-POLICY-2025-a419cb	Corporate Credit Card Policy	Regulates use of corporate credit cards for business expenses.	2025-04-11	Active
ADMIN-POLICY-2025-81201a	Travel and Reimbursement Policy	Defines rules for employee travel and expense reimbursement.	2025-04-11	Active
ADMIN-POLICY-2025-176b38	Warranty Policy	Provides a one-year warranty for product defects, covering parts and labor.	2025-04-11	Active
ADMIN-POLICY-2025-7fe723	Return and Refund Policy	Establishes guidelines for returning and refunding purchased products.	2025-04-11	Active
ADMIN-POLICY-2025-cc0488	No-Cancellation Policy	Prevents order cancellations due to production and supply chain considerations.	2025-04-11	Active
ADMIN-POLICY-2025-d3a0ca	Discount Policy	Outlines eligibility for bulk, loyalty, and promotional discounts.	2025-04-11	Active
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.products (product_id, product_name, description, selling_price, stock_level, unit_of_measure, batch_no, item_status, warranty_period, policy_id, content_id) FROM stdin;
ADMIN-PROD-2025-fe6c97	A9	Used for critical patient or longer surgery, close-loop anesthesia.	47726.64	631	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-319fae	AirStart10	CPAP therapy device for sleep apnea treatment.	10951.20	443	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-9c8bbf	B2 Infant Incubator	Controlled environment for newborn care for optimal temperature and humidity.	1114666.00	540	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-f1ad06	B3 Neonatal Incubator	Advanced life support system for premature infants, regulating vital parameters.	218400.00	599	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-52bf2a	B8/B6 Neonatal Incubator	Intensive care unit for critically ill newborns, providing advanced monitoring and treatment capabilities.	249756.00	693	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-b44bc9	BeneFusion 5 Series	Infusion pumps for precise medication and fluid delivery.	135266.04	496	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-7871b8	BeneFusion e Series	Advanced infusion systems with smart features for enhanced safety.	128700.00	331	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-aa1c8e	BeneFusion n Series	Portable infusion pumps for ambulatory patient care.	128700.00	554	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-3f12a8	BeneHeart AED C2 and D1 PRO	Automated external defibrillators for emergency cardiac resuscitation.	259543.44	407	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-8e1a8d	BeneHeart D3	Professional defibrillator monitor for cardiac resuscitation and patient monitoring.	218673.00	585	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-1dc59b	BeneHeart D6	Portable defibrillator monitor with advanced monitoring capabilities.	3954.60	400	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-aa456d	BeneHeart R12	Electrocardiograph (ECG) device for cardiac diagnostic testing.	3954.60	636	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-abca9c	BeneHeart R3	Compact electrocardiograph for routine ECG measurements.	3954.60	366	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-5e90b5	BeneVision CMS	Central monitoring system for patient data management.	3954.60	492	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-b61a90	BeneVision N Series	Patient monitors providing comprehensive physiological measurements.	3954.60	421	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-44afc4	BeneVision N1	Portable patient monitor for continuous vital signs monitoring.	3954.60	613	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-18b0e8	BL70 Infant Phototherapy Equipment	Light therapy device for treating neonatal jaundice.	6076.20	557	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-67e15f	BQ80 Infant Radiant Warmer	Radiant heat source for maintaining newborn body temperature.	10756.20	508	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-93b1cb	EMMA Capnograph	Device for measuring carbon dioxide levels in exhaled breath.	3900.00	511	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-5db948	ePM Series	Patient monitors for vital signs measurement and display.	2457.00	597	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-2aa802	HyBase 3000	Operating table for surgical procedures.	32104.80	372	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-b42e3f	HyBase 6100/6100 PLUS	Advanced operating tables with specialized features.	33290.40	424	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-9e5700	HyBase V8/V8 Classic	Versatile operating tables for various surgical specialties.	33290.40	642	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-0aee27	HyBase V9	High-end operating table with advanced positioning capabilities.	33290.40	439	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-b5978f	HyLED 200 M	Surgical light for operating room illumination.	834.60	380	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-f57a52	HyLED 600	High-performance surgical light with adjustable settings.	834.60	606	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-dbe3ca	HyLED 600M	Mobile surgical light for flexible use.	780.00	619	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-ca38e5	HyLED 7 Series	Advanced surgical lights with optimal illumination and control.	1872.00	453	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-7a2c68	HyLED 760	High-quality surgical light with excellent light output.	1872.00	580	set	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
ADMIN-PROD-2025-e891e0	HyLED 760M	Mobile version of HyLED 760 surgical light.	5616.00	384	pcs	BN-20240331	Active	12	ADMIN-POLICY-2025-176b38	\N
\.


--
-- Data for Name: raw_materials; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.raw_materials (material_id, material_name, description, unit_of_measure, cost_per_unit, vendor_code) FROM stdin;
ADMIN-MATERIAL-2025-0f17fa	AI Driven Electronics Component	A durable, shatter-resistant plastic for medical enclosures.	set	3600.00	\N
ADMIN-MATERIAL-2025-ef3fda	Casing	Outer shell, made of plastic or metal.	pcs	1900.00	\N
ADMIN-MATERIAL-2025-ed320b	Chambers	A scintillation material used in X-ray detectors for imaging.	unit	5198.00	\N
ADMIN-MATERIAL-2025-b7f4a5	Clamps	Enclosed spaces within medical devices that regulate gas or fluid flow.	pcs	70.00	\N
ADMIN-MATERIAL-2025-24fcc5	Coatings	Fasteners that secure tubing, wires, or components in place.	pcs	1055.00	\N
ADMIN-MATERIAL-2025-5ebcb4	Heating and Drying System	A highly conductive metal used in electronic circuits and medical sensors.	unit	8500.00	\N
ADMIN-MATERIAL-2025-ba8edd	Polycarbonate	Durable plastic used in eyewear and medical devices.	kg	549.00	\N
ADMIN-MATERIAL-2025-7da3cc	Polyethylene	A flexible plastic used in medical tubing and packaging.	kg	55.00	\N
ADMIN-MATERIAL-2025-77527a	Power System	Components for generating, storing, and distributing electrical power.	unit	1480.00	\N
ADMIN-MATERIAL-2025-464b29	Pump	A device that moves fluids or gases in medical applications.	pcs	16600.00	\N
ADMIN-MATERIAL-2025-16ca99	Purification Media	Materials that filter and remove impurities in medical applications.	kg	140.00	\N
ADMIN-MATERIAL-2025-868c8b	Sensors	Detect physical properties and convert them into signals.	pcs	4500.00	\N
ADMIN-MATERIAL-2025-5febb4	Structural Frame & Casing	The main framework and enclosure of medical equipment.	set	2500.00	\N
ADMIN-MATERIAL-2025-ced2d3	Suction	A process that removes fluids or gases using negative pressure.	pcs	399.00	\N
ADMIN-MATERIAL-2025-5f28a9	Ultrasound Transducer	A sensor that converts electricity into ultrasound for diagnostics.	unit	27800.00	\N
ADMIN-MATERIAL-2025-9bc91c	Acrylic	A clear, durable plastic used in optics, and displays.	kg	200.00	\N
ADMIN-MATERIAL-2025-266ce4	Acrylonitrile Butadiene Styrene (ABS)	Tough plastic used in consumer products, electronics, and medical devices.	pcs	90.00	\N
ADMIN-MATERIAL-2025-2d9cc3	Airflow Components	Measure air movement, used in HVAC and respiratory devices.	set	1250.00	\N
ADMIN-MATERIAL-2025-ffa6b9	Aluminum	A metal used in frames and casings.	kg	250.00	\N
ADMIN-MATERIAL-2025-c2c12c	Aluminum Alloys	Aluminum mixed with other metals for improved strength and resistance.	set	2500.00	\N
ADMIN-MATERIAL-2025-c8460b	Anesthetic Delivery System	System for safely delivering anesthetics to patients.	set	450000.00	\N
ADMIN-MATERIAL-2025-3c891b	Bacterial Filters	Traps and removes bacteria from air.	pcs	500.00	\N
ADMIN-MATERIAL-2025-2c7851	Battery	Power source that stores and releases electrical energy.	pcs	18900.00	\N
ADMIN-MATERIAL-2025-27843d	Borosilicate Glass	A power source of medical device, rechargeable or disposable.	kg	60.00	\N
ADMIN-MATERIAL-2025-1ab9e9	Buffering Agent	Substance that stabilizes pH, used in biological and chemical applications.	kg	1000.00	\N
ADMIN-MATERIAL-2025-3b1a5d	Buttons	Switches that initiate controls in devices.	pcs	400.00	\N
ADMIN-MATERIAL-2025-4fcfb8	Cables	Transmit electrical signals or power between components.	mm	1000.00	\N
ADMIN-MATERIAL-2025-2a9a62	Canister Body	Electrical wiring used to connect and transmit signals between components.	pcs	703.00	\N
ADMIN-MATERIAL-2025-387b6f	Capacitors	Store and release electrical energy to filter signals.	pcs	95.00	\N
ADMIN-MATERIAL-2025-1c4bc2	Capnography Sensor	A sensor used to monitor CO₂ levels in respiratory systems.	kg	100.00	\N
\.


--
-- Data for Name: roles_permission; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.roles_permission (role_id, role_name, description, permissions, access_level) FROM stdin;
ADMIN-ROLE-2025-89bcd0	Chief Accountant	Oversees all accounting operations and financial compliance.	Accounting	Full Access
ADMIN-ROLE-2025-09be11	Accounting Supervisor	Supervises accounting transactions and reporting.	Accounting	Full Access
ADMIN-ROLE-2025-1cc113	Administrative Manager	Leads administrative support functions.	Admin	Full Access
ADMIN-ROLE-2025-d4b00c	Office Administrator	Handles internal admin communications and records.	Admin	Read-Only
ADMIN-ROLE-2025-b39547	Distribution Manager	Manages distribution networks and delivery schedules.	Distribution	Full Access
ADMIN-ROLE-2025-868288	Chief Financial Officer	Directs financial strategy and corporate finance.	Finance, Accounting, Management	Full Access
ADMIN-ROLE-2025-ae594d	Finance Manager	Oversees finance department and reporting.	Finance	Full Access
ADMIN-ROLE-2025-3a3f37	Human Resources Director	Leads human resource strategy, compliance, and employee management.	Human Resources, Management	Full Access
ADMIN-ROLE-2025-7ae36b	Human Resources Manager	Manages Human Resources processes and employee services.	Human Resources	Full Access
ADMIN-ROLE-2025-7ac5bd	Inventory Manager	Directs inventory operations and logistics.	Inventory	Full Access
ADMIN-ROLE-2025-deb601	Chief Executive Officer	Leads all corporate and strategic decisions.	Management	Full Access
ADMIN-ROLE-2025-d5c1a7	Chief Operations Officer	Oversees company operations and performance.	Management, Operations	Full Access
ADMIN-ROLE-2025-176a23	General Manager	Supervises daily operations across departments.	Management	Full Access
ADMIN-ROLE-2025-7c221d	Assistant Manager	Assists department heads and monitors staff.	Management	Read-Only
ADMIN-ROLE-2025-5cf55c	Material Resource Planning Manager	Manages material requirement planning processes.	Material Resource Planning	Full Access
ADMIN-ROLE-2025-e8db0d	Operations Manager	Coordinates company operations and logistics.	Operations	Full Access
ADMIN-ROLE-2025-0cbec1	Production Manager	Leads production planning and manufacturing activities.	Production	Full Access
ADMIN-ROLE-2025-afb7d9	Project Manager	Manages project execution and delivery.	Production	Full Access
ADMIN-ROLE-2025-8ac05f	Purchasing Manager	Oversees procurement and vendor operations.	Purchasing	Full Access
ADMIN-ROLE-2025-0aadba	Sales Director	Leads company sales strategy and performance.	Sales	Full Access
ADMIN-ROLE-2025-1c8e4a	Sales Manager	Supervises sales activities and customer accounts.	Sales	Full Access
ADMIN-ROLE-2025-394bd0	Customer Service Manager	Directs customer support and service delivery.	Services	Read-Only
ADMIN-ROLE-2025-c881f3	Maintenance Manager	Leads maintenance and facilities management.	Operations, Inventory	Full Access
ADMIN-ROLE-2025-3ca6e7	IT Manager	Oversees IT systems and infrastructure.	Admin	Read-Only
ADMIN-ROLE-2025-c454dc	Network Administrator	Maintains internal network infrastructure.	Admin	Full Access
ADMIN-ROLE-2025-004c78	System Administrator	Configures and manages server infrastructure.	Admin	Full Access
ADMIN-ROLE-2025-081f06	Quality Control Inspector	Inspects and verifies product quality standards.	Production	Read-Only
ADMIN-ROLE-2025-897949	HSE Manager	Manages health, safety, and environmental programs.	Admin, Operations, Project Management, Human Resources, Services	Full Access
ADMIN-ROLE-2025-b9108b	Security Manager	Supervises physical security and procedures.	Management	Read-Only
ADMIN-ROLE-2025-3c3432	Project Accountant	Tracks and manages financials for projects.	Project Management, Accounting	Full Access
ADMIN-ROLE-2025-0c1cb5	Inventory Specialist	Handles specialized inventory planning tasks.	Inventory	Read-Only
ADMIN-ROLE-2025-4bf75d	System Migration Consultant	Oversees system data migration and transitions.	Admin	Full Access
ADMIN-ROLE-2025-f6ec13	Audit Assistant	Supports audit processes and data validation.	Accounting	Read-Only
ADMIN-ROLE-2025-6f346f	Data Entry Specialist	Inputs and updates administrative data.	Admin	Read-Only
ADMIN-ROLE-2025-e1463f	Marketing Assistant	Supports marketing initiatives and campaigns.	Sales	Read-Only
ADMIN-ROLE-2025-f034f8	Sales Promoter	Promotes products in field and event settings.	Sales	Read-Only
ADMIN-ROLE-2025-1919fa	Graphic Designer	Designs digital/print assets for campaigns.	Management	Read-Only
ADMIN-ROLE-2025-89b615	Legal Consultant	Advises on legal matters and compliance.	Management	Read-Only
ADMIN-ROLE-2025-6b8d5b	Company Nurse	Provides medical support and employee wellness.	Management	Read-Only
ADMIN-ROLE-2025-9972cf	Holiday Sales Associate	Seasonal role assisting with holiday promotions.	Sales	Read-Only
ADMIN-ROLE-2025-275dbb	Tax Season Accountant	Handles accounting during peak tax season.	Accounting	Full Access
ADMIN-ROLE-2025-b126aa	Summer Intern	Temporary support for business operations.	Management	Read-Only
ADMIN-ROLE-2025-b08ee3	Christmas Warehouse Helper	Supports warehouse logistics during holidays.	Management, Distribution	Read-Only
ADMIN-ROLE-2025-22fbe3	New Year Event Staff	Temporary event coordination during year-end.	Management	Read-Only
ADMIN-ROLE-2025-dc91df	Logistic Support	Assists with logistics and routing.	Distribution	Read-Only
ADMIN-ROLE-2025-8a5374	Temporary Security Guard	Provides security support during events or peak seasons.	Management	Read-Only
ADMIN-ROLE-2025-0ce77d	Product Demonstrator	Demonstrates products at events or stores.	Sales	Read-Only
ADMIN-ROLE-2025-290396	Promotion Staff	Assists in executing promotional events.	Sales	Read-Only
ADMIN-ROLE-2025-6343ca	Product Ambassador	Represents brand/products at events.	Sales	Read-Only
ADMIN-ROLE-2025-e3c711	Payroll Officer	Processes and administers payroll operations.	Accounting, Human Resources	Full Access
ADMIN-ROLE-2025-35cdac	Bookkeeper	Maintains and records daily financial transactions.	Accounting	Read-Only
ADMIN-ROLE-2025-4f1c3b	Financial Analyst	Analyzes financial data and business trends.	Finance	Read-Only
ADMIN-ROLE-2025-def9fb	Audit Officer	Conducts internal audits for compliance and accuracy.	Accounting	Read-Only
ADMIN-ROLE-2025-cc4797	Receptionist	Manages front desk and visitor relations.	Management	Read-Only
ADMIN-ROLE-2025-c2c61f	Clerk	Provides basic clerical and filing duties.	Management	Read-Only
ADMIN-ROLE-2025-1173e9	Executive Assistant	Supports executive operations and communications.	Management	Read-Only
ADMIN-ROLE-2025-381bd2	Warehouse Supervisor	Oversees warehouse and inventory workflows.	Inventory, Distribution	Full Access
ADMIN-ROLE-2025-a7500b	Dispatch Officer	Manages daily dispatch of goods.	Distribution	Read-Only
ADMIN-ROLE-2025-b84fe3	Delivery Truck Driver	Delivers company goods and packages.	Distribution	Read-Only
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.users (user_id, employee_id, first_name, last_name, email, password, role_id, status, type, created_at, updated_at) FROM stdin;
ADMIN-USER-2025-9561fd	E001	Kate	Tan	kate.tan@kinetiq.ph	$2a$06$fqR88lEnMvkgInw7gHjWSe3d.dCnb6Lp9kAuOC5ihDeyIlBvtPcJi	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-1372a4	E048	Camille	Rivera	camille.rivera@kinetiq.ph	$2a$06$9UYyHI69IDzsy06GM0Ubv.toyoOEqq80YlPXl0/FEKoExH3pxcMIu	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-de4098	E150	Francis	Lim	francis.lim@kinetiq.ph	$2a$06$vhqZX30n4mpZnB.XUK9Ug.fyMTRyRDVVMzZGQYDzsXZsEyjOuMRd6	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-274e92	E010	Karen	Mendoza	karen.mendoza@kinetiq.ph	$2a$06$3c8Ua3ojBrKRas9KCZ6.XO4C6Bbc0peAImVK4MsRBdlEt0lbuYQ/u	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-d8f997	E019	Juan	Dela Cruz	juan.delacruz@kinetiq.ph	$2a$06$QbdNCvOPtZ2fK.f0FK1Spu7BEk/lh1yWOoQtBDT896C6sif8uezhm	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-4f76b4	E120	Aaron	Dela Cruz	aaron.delacruz@kinetiq.ph	$2a$06$ZpeO2myNRKyJa8ew8sCrE.i/CIT12t7J2miHhd/TRVWzFCZoAOosa	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-28acb9	E133	Madison	Ferrer	madison.ferrer@kinetiq.ph	$2a$06$N6o3wWlygoFtx.pj1ElcxOVRt7lDeUAmuG00XIpSmv3K1ckKm6cBm	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-8ee490	E167	Adrian	Cruz	adrian.cruz@kinetiq.ph	$2a$06$wOD0.aEa/C928Vhc37k8COpikf8NeZeVwnevzG/fkQOuVMelZ5/zq	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-a16b83	E002	James	Marticio	james.marticio@kinetiq.ph	$2a$06$6exYnoEndSd7MqqbJFoWcuRzpdekO9wMeDemEHAG/UX0qNsYpddii	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-61adef	E004	Maria	Lopez	maria.lopez@kinetiq.ph	$2a$06$oUwCpcbEipo1gssLiUJ63.Un9WluN9NaIOVVL12Aafwq8d56SdT4G	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-63490c	E178	Angelo	Santos	angelo.santos@kinetiq.ph	$2a$06$eudeKQ24bKrZkV4UeC.JCufuVIUC0oiHJ1JVyUyHqPXhS4fVGrs1.	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-4acfff	E179	Maria	Dela Cruz	maria.delacruz@kinetiq.ph	$2a$06$.3.iHbdqBhDiGE.hup5zJ.VImgE3KH/zK7cEaI3fIVQGCeiwSiHO2	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-fe33dc	E180	Joseph	Reyes	joseph.reyes@kinetiq.ph	$2a$06$7GKotuERadzmhi0EPvExn.j4.S2Pb3LocwGrI30FQ0tY/LxIJ5OT.	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-d45ab5	E181	Katrina	Villanueva	katrina.villanueva@kinetiq.ph	$2a$06$FmSNKhaxowUB165.rVQaGO88MkBMZ3midrGGQ1stUQCCCRh4Gm1z6	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-386e4d	E182	Mark	Buenaventura	mark.buenaventura@kinetiq.ph	$2a$06$vPCmz6TXKATrfNeSXMuTEuN5pG1Eb48WKl9UMgJlG6ByCfvwEoX6y	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-54ec04	E183	Luis	Mendoza	luis.mendoza@kinetiq.ph	$2a$06$bgenQdMI1l4u92eFcYEfqecLEQQ1UrdCAEeZE5YtzMPup1SYRir66	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-b0d80f	E184	Maria	Santos	maria.santos@kinetiq.ph	$2a$06$cgh5OZuvi81cP13RpskZAeKZcsyXujRUL.0A1CMEGdUmjjbcqwe4y	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-998fbf	E185	Nico	Perez	nico.perez@kinetiq.ph	$2a$06$RNLAhaK30u4m5E/4e2Gt0OTaq86Xalzy/GF/S.lsjsnoGGqwy/rse	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-ba0fef	E186	Olivia	Tan	olivia.tan@kinetiq.ph	$2a$06$m/8NYm/Nbuc2b5HKCkRKFu2NW/UUfAFQmoLGWilagNnu9x1Ujfo6O	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-c9c747	E187	Paolo	Aguila	paolo.aguila@kinetiq.ph	$2a$06$OY3s4whztDYmWYeZ6gDTiuxcoHcpcPOecBtuEKl.TTDuDdU2Nlowu	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-2732fe	E188	Andrea	Gomez	andrea.gomez@kinetiq.ph	$2a$06$49mjeQBtvXSNhofEV9Uv.OYTlPJyXYqAF8E9KD79LjhK1hxTHc.Qe	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-c7a233	E189	Christian	Mendoza	christian.mendoza@kinetiq.ph	$2a$06$AkKIaSKTMj.KpqF7R6w9LeTgFeEYxOiGYfOREpaSLXID78x/xMQa.	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-a2d06d	E190	Patricia	Lim	patricia.lim@kinetiq.ph	$2a$06$i5UCK.J.LwutOBjA9LZOFuGjhvHPXvEvMTV26cdK4FHAgDCncdZ82	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-83c43a	E191	Daniel	Ramos	daniel.ramos@kinetiq.ph	$2a$06$enx7hV8RBO8zooYLXj76MuFbZz/v7hHBF6tLkn/5uAezrKPk6FkOq	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-1d5304	E192	Sofia	Navarro	sofia.navarro@kinetiq.ph	$2a$06$H4UqhHO7vaJtB.ZLB81CtuS7ZlPVdLjPYTut196CniMszE4THa6/e	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-12b70a	E193	Quentin	Soriano	quentin.soriano@kinetiq.ph	$2a$06$bunOVdmzh0ZvgK2zV46A4OvrF.g75Mg97f55uqD6rwezMOMh66C26	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-f0e5da	E194	Rhea	Mendoza	rhea.mendoza@kinetiq.ph	$2a$06$59FqsObpclvGz8n/NtdbOuj.5uFNYPLjSMZbWofuKK//UrX5aOW5W	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-328932	E195	Simon	Reyes	simon.reyes@kinetiq.ph	$2a$06$cOd/QpzX12stkTtHPvU0Ruk1ecnRasdpc5.wPu6.lu6cWFSOIgtfq	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-7bb9da	E196	Tanya	Alonzo	tanya.alonzo@kinetiq.ph	$2a$06$W3sg6DUimzZ5VoKpBmGcC.RgNSYCXcoW.kI5XKQ5rPBTkEeakYMrO	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ADMIN-USER-2025-7f3832	E197	Victor	Castro	victor.castro@kinetiq.ph	$2a$06$QyRoX30k/KRCt6Y0fHb.Vu8HTVv3kuqCvRfhrpM4ARKiUIMuHxgAu	\N	Active	Employee	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: vendor; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.vendor (vendor_code, application_reference, vendor_name, contact_person, status) FROM stdin;
ADMIN-VENDOR-2025-6df215	PURCHASING-VEP-2025-90da27	Beta Materials	Jane Smith	Active
ADMIN-VENDOR-2025-9b80dd	PURCHASING-VEP-2025-a9bf9e	Epsilon Tools	Charlie White	Active
ADMIN-VENDOR-2025-1e68b8	PURCHASING-VEP-2025-9cc6f5	Eta Chemicals	Edward Gray	Active
ADMIN-VENDOR-2025-062773	PURCHASING-VEP-2025-bd4e10	Kappa Textiles	Helen Blue	Active
\.


--
-- Data for Name: warehouse; Type: TABLE DATA; Schema: admin; Owner: postgres
--

COPY admin.warehouse (warehouse_id, warehouse_location, stored_materials) FROM stdin;
ADMIN-WARE-2025-6cb651	Manila	AI-Driven Electronic Components, Casing, Chambers
ADMIN-WARE-2025-875847	Cebu	Clamps, Coatings, Heating & Drying System
ADMIN-WARE-2025-b203c6	Davao	Polycarbonate, Polyethylene, Power system
ADMIN-WARE-2025-aadd31	Quezon City	Pump, Purification Media, Sensors
ADMIN-WARE-2025-a11f55	Pasig	Structural Frame & Casing, Suction, Ultrasound Transducer
ADMIN-WARE-2025-8dd3fa	Makati	Acrylic, Acrylonitrile Butadiene Styrene (ABS), Airflow Components
ADMIN-WARE-2025-d2018c	Taguig	Aluminum, Aluminum Alloys, Anesthetic Delivery System
ADMIN-WARE-2025-727533	Bacolod	Bacterial filters, Battery, Borosilicate Glass
ADMIN-WARE-2025-c60c51	Iloilo	Buffering Agent, Buttons, Cables
ADMIN-WARE-2025-d7f2cf	Cagayan de Oro	Canister Body, Capacitors, Capnography Sensor
ADMIN-WARE-2025-b17a50	General Santos	AI-Driven Electronic Components, Polycarbonate, Sensors
ADMIN-WARE-2025-44406a	Baguio	Casing, Battery, Borosilicate Glass
ADMIN-WARE-2025-25a9d5	Zamboanga	Power System, Suction, Clamps
ADMIN-WARE-2025-ef4fe9	Batangas	Pump, Heating and Drying System, Airflow Components
ADMIN-WARE-2025-e5d896	Cavite	Aluminum, Purification Media, Coatings
ADMIN-WARE-2025-f1561c	Laguna	Polyethylene, Capacitors, Buttons
ADMIN-WARE-2025-383e55	Pampanga	Acrylic, Structural Frame & Casing, Buffering Agent
ADMIN-WARE-2025-555b4d	Tarlac	Chambers, Anesthetic Delivery System, Capnography Sensor
ADMIN-WARE-2025-4887f6	Naga	Filing Cabinet - Steel, Monitor - LG UltraWide, Whiteboard - Magnetic
ADMIN-WARE-2025-88d557	Dumaguete	UPS - APC Smart-UPS, Router - Cisco RV340, Logitech Brio Webcam
\.


--
-- Data for Name: billing_receipt; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.billing_receipt (billing_receipt_id, delivery_receipt_id, sales_invoice_id, service_billing_id, total_receipt) FROM stdin;
DIS-BR-2025-85415f	\N	\N	\N	100.50
DIS-BR-2025-5e49f1	\N	\N	\N	250.75
DIS-BR-2025-2bdc53	\N	\N	\N	175.30
DIS-BR-2025-f0252a	\N	\N	\N	300.00
DIS-BR-2025-1472e6	\N	\N	\N	90.45
DIS-BR-2025-68780e	\N	\N	\N	120.99
DIS-BR-2025-ea8b5b	\N	\N	\N	450.25
DIS-BR-2025-9f60e5	\N	\N	\N	210.60
DIS-BR-2025-42f709	\N	\N	\N	315.80
DIS-BR-2025-3b30d7	\N	\N	\N	500.00
\.


--
-- Data for Name: carrier; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.carrier (carrier_id, carrier_name, service_type, carrier_count) FROM stdin;
DIS-CAR-2025-34377a	\N	Express	15
DIS-CAR-2025-5afde5	\N	Standard	25
DIS-CAR-2025-0ca9ca	\N	Same-day	10
DIS-CAR-2025-ed3f8e	\N	Express	18
DIS-CAR-2025-dcbea2	\N	Standard	20
DIS-CAR-2025-41a739	\N	Same-day	12
DIS-CAR-2025-1dc307	\N	Express	22
DIS-CAR-2025-ac727e	\N	Standard	17
DIS-CAR-2025-7b24e8	\N	Same-day	1
DIS-CAR-2025-90aa02	\N	Express	30
\.


--
-- Data for Name: delivery_order; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.delivery_order (del_order_id, order_status, content_id, is_project_based, is_partial_delivery, service_order_id, stock_transfer_id, sales_order_id, approval_request_id, del_type) FROM stdin;
DIS-DO-2025-ba7214	Approved	\N	Non-Project Based	No	\N	\N	\N	\N	Internal Delivery
DIS-DO-2025-84645e	Approved	\N	Project Based	No	\N	\N	\N	\N	External Delivery
DIS-DO-2025-9b2f45	Approved	\N	Non-Project Based	Yes	\N	\N	\N	\N	Internal Delivery
DIS-DO-2025-8fa244	Approved	\N	Project Based	No	\N	\N	\N	\N	Internal Delivery
DIS-DO-2025-e2e611	Created	\N	Non-Project Based	No	\N	\N	\N	\N	Internal Delivery
DIS-DO-2025-f738e3	Approved	\N	Project Based	Yes	\N	\N	\N	\N	External Delivery
DIS-DO-2025-faaf47	Rejected	\N	Non-Project Based	No	\N	\N	\N	\N	Internal Delivery
DIS-DO-2025-e4c3ce	Approved	\N	Project Based	Yes	\N	\N	\N	\N	Internal Delivery
DIS-DO-2025-52d43c	Created	\N	Non-Project Based	No	\N	\N	\N	\N	Internal Delivery
DIS-DO-2025-e4e630	Approved	\N	Project Based	No	\N	\N	\N	\N	External Delivery
\.


--
-- Data for Name: delivery_receipt; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.delivery_receipt (delivery_receipt_id, delivery_date, received_by, signature, receipt_status, shipment_id, total_amount, receiving_module) FROM stdin;
DIS-DR-2025-5d7c50	2023-01-19	\N	James Williams	Received	\N	1500.00	\N
DIS-DR-2025-9eb898	2023-01-27	\N	Tina Rogers	Received	\N	1200.00	\N
DIS-DR-2025-a8616b	2023-02-10	\N	Luis Martinez	Received	\N	1800.00	\N
DIS-DR-2025-8fd80b	\N	\N	Aaron Anderson	Pending	\N	900.00	\N
DIS-DR-2025-e49f36	\N	\N	Angela Adams	Pending	\N	800.00	\N
DIS-DR-2025-d72568	2023-03-16	\N	Michael Johnson	Received	\N	1600.00	\N
DIS-DR-2025-69df7f	2023-03-25	\N	Sarah Brown	Received	\N	1400.00	\N
DIS-DR-2025-fb7338	\N	\N	Amanda Allen	Rejected	\N	0.00	\N
DIS-DR-2025-c53b67	\N	\N	Andrew Arnold	Pending	\N	700.00	\N
DIS-DR-2025-5ec51d	\N	\N	Alyssa Abbott	Rejected	\N	0.00	\N
\.


--
-- Data for Name: failed_shipment; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.failed_shipment (failed_shipment_id, failure_date, failure_reason, resolution_status, shipment_id) FROM stdin;
DIS-FS-2025-a799e7	\N	Incorrect shipping address	\N	\N
DIS-FS-2025-cdb79c	\N	Package lost in transit	\N	\N
DIS-FS-2025-0ff370	\N	Carrier delay	\N	\N
DIS-FS-2025-749e7d	\N	Damaged during loading	\N	\N
DIS-FS-2025-55db91	\N	Weather-related delay	\N	\N
DIS-FS-2025-df6fd9	\N	Vehicle breakdown	\N	\N
DIS-FS-2025-88b1b4	\N	Package misrouted	\N	\N
DIS-FS-2025-13d79d	2023-04-06	Missing documentation	Pending	\N
DIS-FS-2025-ae5789	\N	Labeling error	\N	\N
DIS-FS-2025-a92aef	\N	Failed delivery attempt	\N	\N
\.


--
-- Data for Name: goods_issue; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.goods_issue (goods_issue_id, issue_date, issued_by, billing_receipt_id) FROM stdin;
DIS-GI-2025-017bb0	2023-01-19	\N	\N
DIS-GI-2025-e5c195	2023-01-27	\N	\N
DIS-GI-2025-e1059c	2023-02-10	\N	\N
DIS-GI-2025-742e78	\N	\N	\N
DIS-GI-2025-615da9	\N	\N	\N
DIS-GI-2025-627e56	2023-03-16	\N	\N
DIS-GI-2025-809c1e	2023-03-25	\N	\N
DIS-GI-2025-7dd208	\N	\N	\N
DIS-GI-2025-a5a2cb	\N	\N	\N
DIS-GI-2025-d3b50f	\N	\N	\N
\.


--
-- Data for Name: logistics_approval_request; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.logistics_approval_request (approval_request_id, request_date, approval_status, approval_date, approved_by, del_order_id) FROM stdin;
DIS-LOR-2025-c1dee4	2023-01-13	Approved	2023-01-14	\N	\N
DIS-LOR-2025-13d40a	2023-01-21	Approved	2023-01-22	\N	\N
DIS-LOR-2025-759585	2023-02-06	Approved	2023-02-07	\N	\N
DIS-LOR-2025-0b5f79	2023-02-19	Approved	2023-02-20	\N	\N
DIS-LOR-2025-8cf149	2023-03-04	Pending	\N	\N	\N
DIS-LOR-2025-81ba71	2023-03-12	Approved	2023-03-13	\N	\N
DIS-LOR-2025-a5cbbf	2023-03-20	Rejected	2023-03-21	\N	\N
DIS-LOR-2025-d41d53	2023-04-03	Approved	2023-04-04	\N	\N
DIS-LOR-2025-0e682b	2023-04-17	Pending	\N	\N	\N
DIS-LOR-2025-f74219	2023-04-25	Approved	2023-04-26	\N	\N
\.


--
-- Data for Name: operational_cost; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.operational_cost (operational_cost_id, additional_cost, total_operational_cost, shipping_cost_id, packing_cost_id) FROM stdin;
DIS-OS-2025-3a6ace	50.00	350.00	\N	\N
DIS-OS-2025-aace79	75.00	650.00	\N	\N
DIS-OS-2025-b2b019	60.00	400.00	\N	\N
DIS-OS-2025-8f899b	100.00	417.50	\N	\N
DIS-OS-2025-87f922	\N	\N	\N	\N
DIS-OS-2025-60294b	65.00	427.50	\N	\N
DIS-OS-2025-f0b563	\N	\N	\N	\N
DIS-OS-2025-8c5cf4	45.00	367.50	\N	\N
DIS-OS-2025-e5e25e	\N	\N	\N	\N
DIS-OS-2025-555c5c	\N	\N	\N	\N
\.


--
-- Data for Name: packing_cost; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.packing_cost (packing_cost_id, material_cost, labor_cost, total_packing_cost) FROM stdin;
DIS-PC-2025-28f807	50.00	75.00	125.00
DIS-PC-2025-5619c6	75.00	100.00	175.00
DIS-PC-2025-9991aa	60.00	90.00	150.00
DIS-PC-2025-806056	100.00	120.00	220.00
DIS-PC-2025-5aa91f	80.00	95.00	175.00
DIS-PC-2025-ae6804	55.00	85.00	140.00
DIS-PC-2025-47ec4b	70.00	110.00	180.00
DIS-PC-2025-5f39cd	90.00	100.00	190.00
DIS-PC-2025-12896e	65.00	75.00	140.00
DIS-PC-2025-1ecd2e	85.00	125.00	210.00
\.


--
-- Data for Name: packing_list; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.packing_list (packing_list_id, packed_by, packing_status, packing_type, total_items_packed, packing_cost_id, picking_list_id, packing_date) FROM stdin;
DIS-PC-2025-0d36f5	\N	Shipped	Box	15	\N	\N	2025-04-06
DIS-PC-2025-20156f	\N	Shipped	Crate	10	\N	\N	2025-04-06
DIS-PC-2025-4f0ba3	\N	Shipped	Box	8	\N	\N	2025-04-06
DIS-PC-2025-d58fdc	\N	Packed	Bubble Wrap	20	\N	\N	2025-04-06
DIS-PC-2025-ac0a96	\N	\N	\N	\N	\N	\N	\N
DIS-PC-2025-bc695b	\N	Shipped	Box	12	\N	\N	2025-04-06
DIS-PC-2025-c39387	\N	\N	\N	\N	\N	\N	\N
DIS-PC-2025-729e74	\N	Shipped	Box	5	\N	\N	2025-04-06
DIS-PC-2025-b51a34	\N	\N	\N	\N	\N	\N	\N
DIS-PC-2025-1f29dd	\N	Pending	\N	\N	\N	\N	\N
\.


--
-- Data for Name: picking_list; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.picking_list (picking_list_id, warehouse_id, picked_by, picked_status, picked_date, approval_request_id) FROM stdin;
DIS-PIL-2025-6d3e0e	\N	\N	Completed	2023-01-15	\N
DIS-PIL-2025-627eba	\N	\N	Completed	2023-01-23	\N
DIS-PIL-2025-41505a	\N	\N	Completed	2023-02-08	\N
DIS-PIL-2025-80c640	\N	\N	In Progress	2023-02-21	\N
DIS-PIL-2025-7944cf	\N	\N	\N	\N	\N
DIS-PIL-2025-e35ffc	\N	\N	Completed	2023-03-14	\N
DIS-PIL-2025-dae628	\N	\N	\N	\N	\N
DIS-PIL-2025-98f006	\N	\N	Completed	2023-04-05	\N
DIS-PIL-2025-26c8ce	\N	\N	\N	\N	\N
DIS-PIL-2025-a874e5	\N	\N	Not Started	\N	\N
\.


--
-- Data for Name: rejection; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.rejection (rejection_id, rejection_status, rejection_reason, rejection_date, delivery_receipt_id) FROM stdin;
DIS-REJ-2025-d1262c	Resolved	Damaged packaging	2023-01-19	\N
DIS-REJ-2025-e978b7	Confirmed	Wrong items delivered	2023-01-27	\N
DIS-REJ-2025-90409c	Pending	Late delivery	2023-02-10	\N
DIS-REJ-2025-6a06eb	\N	Incorrect address provided	\N	\N
DIS-REJ-2025-8feed7	\N	Labeling mismatch	\N	\N
DIS-REJ-2025-1995a0	Resolved	Incomplete delivery	2023-03-16	\N
DIS-REJ-2025-ee92cf	Confirmed	Product quality issues	2023-03-25	\N
DIS-REJ-2025-02171e	Confirmed	Documentation errors	2023-04-06	\N
DIS-REJ-2025-fcee26	\N	Missing accessories	\N	\N
DIS-REJ-2025-7bef0b	Confirmed	Damaged goods	2023-04-27	\N
\.


--
-- Data for Name: rework_order; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.rework_order (rework_id, assigned_to, rework_status, rework_date, expected_completion, rejection_id, failed_shipment_id, rework_types) FROM stdin;
DIS-RO-2025-b15bac	\N	Completed	2023-01-20	2023-01-21 17:00:00	\N	\N	Rejection
DIS-RO-2025-d786e2	\N	In Progress	2023-01-28	2023-01-30 17:00:00	\N	\N	Failed Shipment
DIS-RO-2025-17dac3	\N	Pending	2023-02-11	2023-02-12 17:00:00	\N	\N	Rejection
DIS-RO-2025-b3aec4	\N	\N	\N	\N	\N	\N	\N
DIS-RO-2025-e4a238	\N	\N	\N	\N	\N	\N	\N
DIS-RO-2025-dbd940	\N	Completed	2023-03-17	2023-03-18 16:00:00	\N	\N	Failed Shipment
DIS-RO-2025-6c25e5	\N	\N	\N	\N	\N	\N	\N
DIS-RO-2025-ae197a	\N	Pending	2023-04-07	2023-04-09 12:00:00	\N	\N	Rejection
DIS-RO-2025-ba0bca	\N	\N	\N	\N	\N	\N	\N
DIS-RO-2025-2c60a8	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: shipment_details; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.shipment_details (shipment_id, carrier_id, shipment_date, shipment_status, tracking_number, estimated_arrival_date, actual_arrival_date, packing_list_id, shipping_cost_id) FROM stdin;
DIS-SD-2025-cd03ca	\N	2023-01-16	Delivered	TRK0001	2023-01-18 14:00:00	2023-01-19 11:30:00	\N	\N
DIS-SD-2025-2e74fe	\N	2023-01-24	Delivered	TRK0002	2023-01-27 16:00:00	2023-01-27 15:45:00	\N	\N
DIS-SD-2025-398276	\N	2023-02-09	Delivered	TRK0003	2023-02-09 18:00:00	2023-02-10 09:15:00	\N	\N
DIS-SD-2025-94e3b9	\N	2023-02-22	Shipped	TRK0004	2023-02-24 12:00:00	\N	\N	\N
DIS-SD-2025-554e38	\N	\N	Pending	TRK0005	\N	\N	\N	\N
DIS-SD-2025-dabeb5	\N	2023-03-15	Delivered	TRK0006	2023-03-16 10:00:00	2023-03-16 16:20:00	\N	\N
DIS-SD-2025-cb02e0	\N	\N	Delivered	TRK0007	2023-03-25 13:00:00	2023-03-25 14:05:00	\N	\N
DIS-SD-2025-d945eb	\N	2023-04-06	Failed	TRK0008	2023-04-08 11:00:00	\N	\N	\N
DIS-SD-2025-ee70b7	\N	\N	Pending	TRK0009	2023-04-21 15:00:00	\N	\N	\N
DIS-SD-2025-6b33c4	\N	\N	Pending	TRK0010	2023-04-29 12:00:00	\N	\N	\N
\.


--
-- Data for Name: shipping_cost; Type: TABLE DATA; Schema: distribution; Owner: postgres
--

COPY distribution.shipping_cost (shipping_cost_id, packing_list_id, cost_per_kg, cost_per_km, weight_kg, distance_km, total_shipping_cost) FROM stdin;
DIS-SC-2025-4dc562	\N	2.50	0.75	25.00	150.00	175.00
DIS-SC-2025-e2f1ba	\N	2.50	0.75	100.00	200.00	400.00
DIS-SC-2025-2081bd	\N	2.50	0.75	40.00	120.00	190.00
DIS-SC-2025-d12161	\N	2.50	0.75	15.00	80.00	97.50
DIS-SC-2025-8f38cf	\N	\N	\N	\N	\N	\N
DIS-SC-2025-171e38	\N	2.75	0.80	30.00	175.00	222.50
DIS-SC-2025-1ae8c1	\N	\N	\N	\N	\N	\N
DIS-SC-2025-81585d	\N	2.75	0.80	22.00	90.00	132.50
DIS-SC-2025-66c308	\N	\N	\N	\N	\N	\N
DIS-SC-2025-b21813	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: budget_allocation; Type: TABLE DATA; Schema: finance; Owner: postgres
--

COPY finance.budget_allocation (budget_allocation_id, budget_approvals_id, total_budget, total_spent, total_remaining_budget, allocated_budget, total_allocated_spent, allocated_remaining_budget, status, start_date, end_date) FROM stdin;
FNC-BAA-2025-957dc1	\N	100000.00	25000.00	75000.00	80000.00	20000.00	60000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-837b56	\N	50000.00	10000.00	40000.00	40000.00	8000.00	32000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-625c53	\N	200000.00	50000.00	150000.00	160000.00	40000.00	120000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-52a104	\N	75000.00	15000.00	60000.00	60000.00	12000.00	48000.00	tentative	2025-08-01	2026-08-01
FNC-BAA-2025-42103d	\N	120000.00	30000.00	90000.00	100000.00	25000.00	75000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-8b2d02	\N	60000.00	12000.00	48000.00	50000.00	10000.00	40000.00	tentative	2025-08-01	2026-08-01
FNC-BAA-2025-cae46d	\N	250000.00	62500.00	187500.00	200000.00	50000.00	150000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-4d9acf	\N	80000.00	16000.00	64000.00	70000.00	14000.00	56000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-a827c4	\N	130000.00	32500.00	97500.00	110000.00	27500.00	82500.00	tentative	2025-08-01	2026-08-01
FNC-BAA-2025-21ec3e	\N	70000.00	14000.00	56000.00	60000.00	12000.00	48000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-d1f8d3	\N	110000.00	27500.00	82500.00	90000.00	22500.00	67500.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-0cd9c1	\N	55000.00	11000.00	44000.00	45000.00	9000.00	36000.00	tentative	2025-08-01	2026-08-01
FNC-BAA-2025-451f58	\N	220000.00	55000.00	165000.00	180000.00	45000.00	135000.00	final	2025-08-01	2026-08-01
FNC-BAA-2025-200de0	\N	90000.00	18000.00	72000.00	80000.00	16000.00	64000.00	final	2025-08-01	2026-08-01
\.


--
-- Data for Name: budget_approvals; Type: TABLE DATA; Schema: finance; Owner: postgres
--

COPY finance.budget_approvals (budget_approvals_id, validation_id, amount_requested, validated_amount, validated_by, approved_by, approval_date, remarks, approval_status) FROM stdin;
FNC-BUA-2025-5081ed	\N	1000.00	950.00	Jenny Jimenez	Yori Perdigon	2023-10-26	Approved	Approved
FNC-BUA-2025-9890cb	\N	1500.50	1500.50	Jenny Jimenez	Yori Perdigon	2023-10-27	Approved	Approved
FNC-BUA-2025-877a3d	\N	750.25	700.00	Jenny Jimenez	Yori Perdigon	2023-10-28	Awaiting Approval	Pending
FNC-BUA-2025-b19c38	\N	2000.00	1800.00	Jenny Jimenez	Yori Perdigon	2023-10-29	For resubmission	Rejected
FNC-BUA-2025-a44b15	\N	1200.75	1200.75	Jenny Jimenez	Yori Perdigon	2023-10-30	Approved	Approved
FNC-BUA-2025-1d3f68	\N	800.00	780.00	Jenny Jimenez	Yori Perdigon	2023-10-31	Awaiting Approval	Pending
FNC-BUA-2025-b6495c	\N	2500.00	2200.00	Jenny Jimenez	Yori Perdigon	2023-11-01	For resubmission	Rejected
FNC-BUA-2025-508a54	\N	900.50	900.50	Jenny Jimenez	Yori Perdigon	2023-11-02	Approved	Approved
FNC-BUA-2025-c71925	\N	1800.25	1750.00	Jenny Jimenez	Yori Perdigon	2023-11-03	Awaiting Approval	Pending
FNC-BUA-2025-6fac1a	\N	1100.00	1000.00	Jenny Jimenez	Yori Perdigon	2023-11-04	For resubmission	Rejected
FNC-BUA-2025-2bfd9b	\N	1350.00	1350.00	Jenny Jimenez	Yori Perdigon	2023-11-05	Approved	Approved
FNC-BUA-2025-3ac758	\N	650.75	600.00	Jenny Jimenez	Yori Perdigon	2023-11-06	Awaiting Approval	Pending
FNC-BUA-2025-a51018	\N	2200.50	2000.00	Jenny Jimenez	Yori Perdigon	2023-11-07	For resubmission	Rejected
FNC-BUA-2025-7293e0	\N	1050.25	1050.25	Jenny Jimenez	Yori Perdigon	2023-11-08	Approved	Approved
\.


--
-- Data for Name: budget_request_form; Type: TABLE DATA; Schema: finance; Owner: postgres
--

COPY finance.budget_request_form (budget_request_id, dept_id, amount_requested, requestor_name, requested_date, expected_start_usage_period, expected_end_usage_period, urgency_level_request, reason_for_request, expense_breakdown_period) FROM stdin;
FNC-BRQ-2025-53b55e	\N	15000.00	Alice Johnson	2023-11-20	2024-01-01	2024-03-31	Medium	Purchase new software licenses.	\N
FNC-BRQ-2025-8c5cb5	\N	25000.50	Bob Smith	2023-11-21	2024-02-15	2024-05-15	High	Urgent server upgrade.	\N
FNC-BRQ-2025-7a3df2	\N	8000.00	Charlie Brown	2023-11-22	2024-03-01	2024-06-30	Low	Office supply replenishment.	\N
FNC-BRQ-2025-b41738	\N	40000.75	David Wilson	2023-11-23	2024-04-10	2024-07-10	Medium	Attend industry conference.	\N
FNC-BRQ-2025-571606	\N	12000.25	Eva Davis	2023-11-24	2024-05-01	2024-08-31	Low	Team building event.	\N
FNC-BRQ-2025-bb5324	\N	60000.00	Frank Miller	2023-11-25	2024-06-15	2024-09-15	High	New marketing campaign.	\N
FNC-BRQ-2025-8e66f0	\N	18000.50	Grace Moore	2023-11-26	2024-07-01	2024-10-31	Medium	Training for new employees.	\N
FNC-BRQ-2025-cc1d07	\N	35000.75	Henry Taylor	2023-11-27	2024-08-10	2024-11-10	High	Replace aging equipment.	\N
FNC-BRQ-2025-a1b0ba	\N	9000.25	Ivy Anderson	2023-11-28	2024-09-01	2024-12-31	Low	Purchase new furniture.	\N
FNC-BRQ-2025-120478	\N	22000.00	Jack Thomas	2023-11-29	2024-10-15	2025-01-15	Medium	Upgrade network infrastructure.	\N
FNC-BRQ-2025-b5966f	\N	45000.50	Karen Jackson	2023-11-30	2024-11-01	2025-02-28	High	Emergency repairs.	\N
FNC-BRQ-2025-ec4631	\N	11000.75	Liam White	2023-12-01	2024-12-10	2025-03-10	Low	Purchase new printer.	\N
FNC-BRQ-2025-942e7c	\N	28000.25	Mia Harris	2023-12-02	2025-01-01	2025-04-30	Medium	Develop new mobile app.	\N
FNC-BRQ-2025-71aeba	\N	70000.00	Noah Martin	2023-12-03	2025-02-15	2025-05-15	High	Expand office space.	\N
\.


--
-- Data for Name: budget_returns_form; Type: TABLE DATA; Schema: finance; Owner: postgres
--

COPY finance.budget_returns_form (budget_return_id, dept_id, budget_request_id, returner_name, return_date, returned_amount, total_amount_requested, reason_returned, expense_history_breakdown) FROM stdin;
FNC-BRT-2025-7ca80a	\N	\N	Alice Johnson	2024-03-31	5000.00	15000.00	Unused Funds	\N
FNC-BRT-2025-7d3f14	\N	\N	Bob Smith	2024-05-15	10000.00	25000.50	Project Cancelled	\N
FNC-BRT-2025-ae857d	\N	\N	Charlie Brown	2024-06-30	2000.00	8000.00	Overestimation	\N
FNC-BRT-2025-65f8ff	\N	\N	David Wilson	2024-07-10	15000.00	40000.75	Unused Funds	\N
FNC-BRT-2025-34af87	\N	\N	Eva Davis	2024-08-31	3000.00	12000.25	Project Cancelled	\N
FNC-BRT-2025-b5e097	\N	\N	Frank Miller	2024-09-15	20000.00	60000.00	Overestimation	\N
FNC-BRT-2025-475649	\N	\N	Grace Moore	2024-10-31	6000.00	18000.50	Unused Funds	\N
FNC-BRT-2025-1693f7	\N	\N	Henry Taylor	2024-11-10	12000.00	35000.75	Project Cancelled	\N
FNC-BRT-2025-ca1707	\N	\N	Ivy Anderson	2024-12-31	2500.00	9000.25	Overestimation	\N
FNC-BRT-2025-030798	\N	\N	Jack Thomas	2025-01-15	8000.00	22000.00	Unused Funds	\N
FNC-BRT-2025-ed3e1c	\N	\N	Karen Jackson	2025-02-28	15000.00	45000.50	Project Cancelled	\N
FNC-BRT-2025-d7e83d	\N	\N	Liam White	2025-03-10	3000.00	11000.75	Overestimation	\N
FNC-BRT-2025-7ca734	\N	\N	Mia Harris	2025-04-30	9000.00	28000.25	Unused Funds	\N
FNC-BRT-2025-083a5b	\N	\N	Noah Martin	2025-05-15	25000.00	70000.00	Project Cancelled	\N
\.


--
-- Data for Name: budget_submission; Type: TABLE DATA; Schema: finance; Owner: postgres
--

COPY finance.budget_submission (budget_submission_id, dept_id, submitter_name, date_submitted, proposed_total_budget, start_usage_period, end_usage_period, expense_breakdown) FROM stdin;
FNC-BUS-2025-b14377	\N	Alice Smith	2023-10-26	50000.00	2024-01-01	2024-12-31	\N
FNC-BUS-2025-a2ab7e	\N	Bob Johnson	2023-10-27	75000.50	2024-02-15	2025-02-14	\N
FNC-BUS-2025-b13bf7	\N	Charlie Williams	2023-10-28	100000.00	2024-03-01	2025-03-31	\N
FNC-BUS-2025-974275	\N	David Brown	2023-10-29	60000.75	2024-04-10	2025-04-09	\N
FNC-BUS-2025-e49ab8	\N	Eva Davis	2023-10-30	90000.25	2024-05-01	2025-05-31	\N
FNC-BUS-2025-cf52ca	\N	Frank Miller	2023-10-31	120000.00	2024-06-15	2025-06-14	\N
FNC-BUS-2025-09d902	\N	Grace Wilson	2023-11-01	80000.50	2024-07-01	2025-07-31	\N
FNC-BUS-2025-9200b8	\N	Henry Moore	2023-11-02	110000.75	2024-08-10	2025-08-09	\N
FNC-BUS-2025-c62fa3	\N	Ivy Taylor	2023-11-03	65000.25	2024-09-01	2025-09-30	\N
FNC-BUS-2025-156f00	\N	Jack Anderson	2023-11-04	95000.00	2024-10-15	2025-10-14	\N
FNC-BUS-2025-bf6aee	\N	Karen Thomas	2023-11-05	130000.50	2024-11-01	2025-11-30	\N
FNC-BUS-2025-7585d4	\N	Liam Jackson	2023-11-06	70000.75	2024-12-10	2025-12-09	\N
FNC-BUS-2025-62fd78	\N	Mia White	2023-11-07	105000.25	2025-01-01	2026-01-31	\N
FNC-BUS-2025-ebaae6	\N	Noah Harris	2023-11-08	140000.00	2025-02-15	2026-02-14	\N
\.


--
-- Data for Name: budget_validations; Type: TABLE DATA; Schema: finance; Owner: postgres
--

COPY finance.budget_validations (validation_id, budget_submission_id, budget_request_id, budget_return_id, validation_date, validated_by, validation_status, remarks, comments, amount_requested, final_approved_amount) FROM stdin;
FNC-BVA-2025-5f7d30	\N	\N	\N	2025-04-01	Julianne Rico	Validated	Approved	Exact Amount Returned	1000.00	1000.00
FNC-BVA-2025-317783	\N	\N	\N	2025-04-02	Julianne Rico	Pending	Awaiting Validation	\N	500.50	\N
FNC-BVA-2025-7d3344	\N	\N	\N	2025-04-03	Julianne Rico	To review	For resubmission	Budget Mismatched	2000.00	1800.00
FNC-BVA-2025-881648	\N	\N	\N	2025-04-04	Julianne Rico	Validated	Approved	Overreturned	750.00	800.00
FNC-BVA-2025-a62418	\N	\N	\N	2025-04-05	Julianne Rico	Validated	Approved	Underreturned	1200.00	1150.00
FNC-BVA-2025-7c1078	\N	\N	\N	2025-04-06	Julianne Rico	Pending	Awaiting Validation	\N	300.75	\N
FNC-BVA-2025-64c13c	\N	\N	\N	2025-04-07	Julianne Rico	To review	For resubmission	Revalidation Needed	1500.00	1500.00
FNC-BVA-2025-e6bb5f	\N	\N	\N	2025-04-08	Julianne Rico	To review	For resubmission	Document Issue	900.00	900.00
FNC-BVA-2025-dd9235	\N	\N	\N	2025-04-09	Julianne Rico	Pending	Awaiting Validation	\N	650.20	\N
FNC-BVA-2025-9e24cb	\N	\N	\N	2025-04-01	Julianne Rico	Validated	Approved	Exact Amount Returned	2500.00	2500.00
FNC-BVA-2025-a762f2	\N	\N	\N	2025-04-02	Julianne Rico	To review	For resubmission	Budget Mismatched	400.00	350.00
FNC-BVA-2025-f34a8c	\N	\N	\N	2025-04-03	Julianne Rico	Validated	Approved	Overreturned	1800.00	1900.00
FNC-BVA-2025-ef4637	\N	\N	\N	2025-04-04	Julianne Rico	Pending	Awaiting Validation	\N	1100.90	\N
FNC-BVA-2025-a78fb1	\N	\N	\N	2025-04-05	Julianne Rico	Validated	Approved	Underreturned	850.00	800.00
\.


--
-- Data for Name: attendance_tracking; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.attendance_tracking (attendance_id, employee_id, date, time_in, time_out, status, late_hours, undertime_hours, is_holiday, holiday_type, created_at, updated_at) FROM stdin;
ATT-20231106-001	E001	2023-11-06	2023-11-06 08:58:00	2023-11-06 17:02:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231107-001	E001	2023-11-07	2023-11-07 09:15:00	2023-11-07 17:00:00	Late	0.25	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231108-001	E001	2023-11-08	2023-11-08 08:55:00	2023-11-08 16:30:00	Half-Day	0.00	0.50	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231109-001	E001	2023-11-09	2023-11-09 08:50:00	2023-11-09 17:05:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231110-001	E001	2023-11-10	2023-11-10 08:45:00	2023-11-10 15:00:00	Half-Day	0.00	2.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231106-179	E179	2023-11-06	2023-11-06 09:20:00	2023-11-06 17:20:00	Late	0.33	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231107-179	E179	2023-11-07	2023-11-07 08:50:00	2023-11-07 17:00:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231108-179	E179	2023-11-08	\N	\N	Absent	0.00	8.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231109-179	E179	2023-11-09	2023-11-09 08:55:00	2023-11-09 17:10:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231110-179	E179	2023-11-10	2023-11-10 09:30:00	2023-11-10 17:25:00	Late	0.50	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231106-189	E189	2023-11-06	2023-11-06 08:40:00	2023-11-06 16:50:00	Present	0.00	0.17	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231107-189	E189	2023-11-07	2023-11-07 08:45:00	2023-11-07 12:00:00	Half-Day	0.00	4.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231108-189	E189	2023-11-08	2023-11-08 08:50:00	2023-11-08 16:55:00	Present	0.00	0.08	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231109-189	E189	2023-11-09	\N	\N	Absent	0.00	8.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231110-189	E189	2023-11-10	2023-11-10 08:55:00	2023-11-10 17:00:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231113-001	E001	2023-11-13	2023-11-13 09:05:00	2023-11-13 17:05:00	Late	0.08	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231114-001	E001	2023-11-14	2023-11-14 08:50:00	2023-11-14 17:00:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231115-001	E001	2023-11-15	2023-11-15 08:55:00	2023-11-15 17:10:00	Present	0.00	0.00	t	Special	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231116-001	E001	2023-11-16	2023-11-16 08:45:00	2023-11-16 16:00:00	Half-Day	0.00	1.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231117-001	E001	2023-11-17	2023-11-17 08:50:00	2023-11-17 17:05:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231113-179	E179	2023-11-13	2023-11-13 08:55:00	2023-11-13 17:00:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231114-179	E179	2023-11-14	2023-11-14 09:10:00	2023-11-14 17:15:00	Late	0.17	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231115-179	E179	2023-11-15	\N	\N	Absent	0.00	8.00	t	Special	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231116-179	E179	2023-11-16	2023-11-16 08:45:00	2023-11-16 17:05:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231117-179	E179	2023-11-17	\N	\N	Absent	0.00	8.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231113-189	E189	2023-11-13	2023-11-13 08:50:00	2023-11-13 16:55:00	Present	0.00	0.08	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231114-189	E189	2023-11-14	2023-11-14 08:55:00	2023-11-14 17:00:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231115-189	E189	2023-11-15	\N	\N	Absent	0.00	8.00	t	Special	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231116-189	E189	2023-11-16	2023-11-16 08:45:00	2023-11-16 12:30:00	Half-Day	0.00	3.50	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
ATT-20231117-189	E189	2023-11-17	2023-11-17 08:50:00	2023-11-17 17:00:00	Present	0.00	0.00	f	\N	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: calendar_dates; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.calendar_dates (date, is_workday, is_holiday, is_special, holiday_name) FROM stdin;
2023-11-06	t	f	f	\N
2023-11-07	t	f	f	\N
2023-11-08	t	f	f	\N
2023-11-09	t	f	f	\N
2023-11-10	t	f	f	\N
2023-11-13	t	f	f	\N
2023-11-14	t	f	f	\N
2023-11-15	f	t	t	Special Holiday
2023-11-16	t	f	f	\N
2023-11-17	t	f	f	\N
2023-11-20	t	f	f	\N
2023-11-21	t	f	f	\N
2023-11-22	t	f	f	\N
2023-11-23	t	t	f	Thanksgiving Day
2023-11-24	t	f	f	\N
2023-11-25	f	f	f	\N
2023-11-26	f	f	f	\N
2023-11-27	t	f	f	\N
2023-11-28	t	f	f	\N
2023-11-29	t	f	f	\N
2023-11-30	t	f	f	\N
2023-10-15	f	f	f	\N
2023-10-16	t	f	f	\N
2023-10-17	t	f	f	\N
2023-10-18	t	f	f	\N
2023-10-19	t	f	f	\N
2023-10-20	t	f	f	\N
2023-10-21	f	f	f	\N
2023-10-22	f	f	f	\N
2023-10-23	t	f	f	\N
2023-10-24	t	f	f	\N
2023-10-25	t	f	f	\N
2023-10-26	t	f	f	\N
2023-10-27	t	f	f	\N
2023-10-28	f	f	f	\N
2023-10-29	f	f	f	\N
2023-10-30	f	t	f	Special Non-Working Holiday
2023-10-31	t	f	f	\N
2023-11-01	f	t	f	All Saints Day
2023-11-02	f	t	t	All Souls Day (Special)
2023-11-03	t	f	f	\N
2023-11-04	f	f	f	\N
2023-11-05	f	f	f	\N
2023-11-11	f	f	f	\N
2023-11-12	f	f	f	\N
\.


--
-- Data for Name: candidates; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.candidates (candidate_id, job_id, first_name, last_name, email, phone, resume_path, application_status, documents, interview_details, offer_details, contract_details, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: department_superiors; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.department_superiors (dept_id, position_id, hierarchy_level) FROM stdin;
D002	POS004	2
D016	POS026	3
D004	POS007	2
D016	POS025	2
D009	POS016	1
D017	POS027	1
D003	POS005	1
D002	POS003	1
D015	POS023	1
D001	POS001	1
D007	POS006	3
D007	POS013	4
D010	POS017	1
D006	POS010	1
D014	POS022	1
D008	POS015	1
D019	POS029	1
D004	POS006	1
D018	POS028	1
D007	POS011	1
D005	POS009	2
D012	POS019	1
D016	POS024	1
D001	POS002	2
D011	POS018	1
D007	POS014	5
D013	POS020	1
D007	POS012	2
D005	POS008	1
D013	POS021	2
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.departments (dept_id, dept_name, is_archived) FROM stdin;
D001	Accounting	f
D002	Administration	f
D003	Distribution	f
D004	Finance	f
D005	Human Resource	f
D006	Inventory	f
D007	Management	f
D008	Material Resource Planning	f
D009	Operations	f
D010	Production	f
D011	Project Management	f
D012	Purchasing	f
D013	Sales	f
D014	Services	f
D015	Maintenance & Facilities	f
D016	IT & Technical Support	f
D017	Quality Assurance & Compliance	f
D018	Health, Safety, and Environment	f
D019	Security	f
\.


--
-- Data for Name: employee_leave_balances; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee_leave_balances (balance_id, employee_id, year, sick_leave_remaining, vacation_leave_remaining, maternity_leave_remaining, paternity_leave_remaining, solo_parent_leave_remaining, unpaid_leave_taken) FROM stdin;
LEAVE-BAL-E001-2023	E001	2023	15	15	105	7	7	0
LEAVE-BAL-E179-2023	E179	2023	0	0	105	7	7	0
LEAVE-BAL-E189-2023	E189	2023	0	0	105	7	7	0
LEAVE-BAL-E001-2025	E001	2025	15	15	105	7	7	0
\.


--
-- Data for Name: employee_performance; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee_performance (performance_id, employee_id, immediate_superior_id, rating, bonus_amount, bonus_payment_month, review_date, updated_at) FROM stdin;
HR-PERF-2025-998758	E001	\N	4	58500.00	12	2023-11-01	2025-04-11 23:12:09.071108
HR-PERF-2025-4ec28b	E010	\N	5	66000.00	12	2023-11-02	2025-04-11 23:12:09.071108
HR-PERF-2025-a94dbb	E019	\N	3	57000.00	12	2023-11-03	2025-04-11 23:12:09.071108
HR-PERF-2025-c1c39d	E048	\N	4	28800.00	12	2023-11-05	2025-04-11 23:12:09.071108
HR-PERF-2025-0b5efb	E120	\N	2	9900.00	12	2023-11-06	2025-04-11 23:12:09.071108
HR-PERF-2025-9eabd4	E150	\N	4	63000.00	12	2023-11-07	2025-04-11 23:12:09.071108
HR-PERF-2025-8b11cc	E133	\N	3	28800.00	12	2023-11-08	2025-04-11 23:12:09.071108
HR-PERF-2025-173ab4	E167	\N	5	27600.00	12	2023-11-09	2025-04-11 23:12:09.071108
HR-PERF-2025-a7c41f	E002	E001	4	34200.00	12	2023-11-10	2025-04-11 23:12:09.071108
HR-PERF-2025-c1f2b0	E004	E002	3	15000.00	12	2023-11-11	2025-04-11 23:12:09.071108
HR-PERF-2025-116a44	E178	E001	4	35100.00	3	2023-08-15	2025-04-11 23:12:09.071108
HR-PERF-2025-b70c62	E179	E048	3	17550.00	6	2023-05-15	2025-04-11 23:12:09.071108
HR-PERF-2025-3b98f0	E180	E150	5	71500.00	9	2023-08-15	2025-04-11 23:12:09.071108
HR-PERF-2025-7ec15c	E181	E010	2	9425.00	12	2023-11-15	2025-04-11 23:12:09.071108
HR-PERF-2025-38d3e3	E182	E010	3	14300.00	12	2023-11-16	2025-04-11 23:12:09.071108
HR-PERF-2025-037fe5	E183	E120	4	19500.00	12	2023-11-17	2025-04-11 23:12:09.071108
HR-PERF-2025-73b16b	E184	E120	3	7800.00	12	2023-11-18	2025-04-11 23:12:09.071108
HR-PERF-2025-2d2c49	E185	E120	5	32500.00	12	2023-11-19	2025-04-11 23:12:09.071108
HR-PERF-2025-8139f6	E186	E010	2	3900.00	12	2023-11-20	2025-04-11 23:12:09.071108
HR-PERF-2025-5e343c	E187	E167	4	24375.00	12	2023-11-21	2025-04-11 23:12:09.071108
HR-PERF-2025-64f306	E188	E001	3	13000.00	1	2024-01-05	2025-04-11 23:12:09.071108
HR-PERF-2025-4a62cb	E189	E010	4	13650.00	7	2023-07-10	2025-04-11 23:12:09.071108
HR-PERF-2025-67a13a	E190	E048	5	42900.00	4	2023-04-20	2025-04-11 23:12:09.071108
HR-PERF-2025-5c7ff9	E191	E133	3	13000.00	1	2024-01-15	2025-04-11 23:12:09.071108
HR-PERF-2025-0cabdf	E192	E120	2	5525.00	1	2024-01-10	2025-04-11 23:12:09.071108
HR-PERF-2025-cc0b2f	E193	E019	4	12187.50	7	2023-07-15	2025-04-11 23:12:09.071108
HR-PERF-2025-7388b2	E194	\N	3	8125.00	1	2024-01-05	2025-04-11 23:12:09.071108
HR-PERF-2025-ec9aa1	E195	E120	5	16250.00	1	2024-01-08	2025-04-11 23:12:09.071108
HR-PERF-2025-118023	E196	E120	4	13650.00	1	2024-01-09	2025-04-11 23:12:09.071108
HR-PERF-2025-347ee4	E197	E120	3	9100.00	1	2024-01-10	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: employee_salary; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employee_salary (salary_id, employee_id, base_salary, daily_rate, effective_date) FROM stdin;
SAL-2023-E001	E001	65000.00	\N	2023-01-01
SAL-2023-E002	E002	38000.00	\N	2023-01-01
SAL-2023-E004	E004	25000.00	\N	2023-01-01
SAL-2023-E010	E010	55000.00	\N	2023-01-01
SAL-2023-E019	E019	95000.00	\N	2023-01-01
SAL-2023-E048	E048	32000.00	\N	2023-01-01
SAL-2023-E120	E120	33000.00	\N	2023-01-01
SAL-2023-E150	E150	70000.00	\N	2023-01-01
SAL-2023-E133	E133	48000.00	\N	2023-01-01
SAL-2023-E167	E167	23000.00	\N	2023-01-01
SAL-2023-E178	E178	\N	1800.00	2023-01-01
SAL-2023-E179	E179	\N	1350.00	2023-01-01
SAL-2023-E180	E180	\N	2750.00	2023-01-01
SAL-2023-E181	E181	\N	1450.00	2023-01-01
SAL-2023-E182	E182	\N	1100.00	2023-01-01
SAL-2023-E183	E183	\N	1000.00	2023-01-01
SAL-2023-E184	E184	\N	600.00	2023-01-01
SAL-2023-E185	E185	\N	1250.00	2023-01-01
SAL-2023-E186	E186	\N	600.00	2023-01-01
SAL-2023-E187	E187	\N	1250.00	2023-01-01
SAL-2023-E188	E188	\N	1000.00	2023-01-01
SAL-2023-E189	E189	\N	700.00	2023-01-01
SAL-2023-E190	E190	\N	1650.00	2023-01-01
SAL-2023-E191	E191	\N	1000.00	2023-01-01
SAL-2023-E192	E192	\N	850.00	2023-01-01
SAL-2023-E193	E193	\N	625.00	2023-01-01
SAL-2023-E194	E194	\N	625.00	2023-01-01
SAL-2023-E195	E195	\N	625.00	2023-01-01
SAL-2023-E196	E196	\N	700.00	2023-01-01
SAL-2023-E197	E197	\N	700.00	2023-01-01
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.employees (employee_id, user_id, dept_id, position_id, first_name, last_name, phone, employment_type, status, reports_to, is_supervisor, created_at, updated_at) FROM stdin;
E001	\N	D001	POS001	Kate	Tan	09165824756	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E048	\N	D006	POS010	Camille	Rivera	09341234567	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E150	\N	D016	POS024	Francis	Lim	09678901236	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E010	\N	D002	POS003	Karen	Mendoza	09139485762	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E019	\N	D003	POS005	Juan	Dela Cruz	09123456789	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E120	\N	D013	POS021	Aaron	Dela Cruz	09171234561	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E133	\N	D014	POS022	Madison	Ferrer	09171234573	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E167	\N	D018	POS028	Adrian	Cruz	09171234590	Regular	Active	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E002	\N	D001	POS002	James	Marticio	09123456789	Regular	Active	E001	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E004	\N	D001	POS004	Maria	Lopez	09154321876	Regular	Active	E002	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E178	\N	D001	POS030	Angelo	Santos	09171234567	Contractual	Active	E001	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E179	\N	D006	POS031	Maria	Dela Cruz	09281234567	Contractual	Active	E048	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E180	\N	D016	POS032	Joseph	Reyes	09391234567	Contractual	Active	E150	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E181	\N	D002	POS033	Katrina	Villanueva	09451234567	Contractual	Active	E010	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E182	\N	D002	POS034	Mark	Buenaventura	09561234567	Contractual	Active	E010	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E183	\N	D013	POS035	Luis	Mendoza	09171234601	Contractual	Active	E120	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E184	\N	D013	POS036	Maria	Santos	09171234602	Contractual	Active	E120	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E185	\N	D013	POS037	Nico	Perez	09171234603	Contractual	Active	E120	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E186	\N	D002	POS038	Olivia	Tan	09171234604	Contractual	Active	E010	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E187	\N	D018	POS039	Paolo	Aguila	09171234605	Contractual	Active	E167	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E188	\N	D001	POS045	Andrea	Gomez	09671234567	Seasonal	Active	E001	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E189	\N	D002	POS046	Christian	Mendoza	09781234567	Seasonal	Active	E010	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E190	\N	D006	POS047	Patricia	Lim	09891234567	Seasonal	Active	E048	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E191	\N	D014	POS048	Daniel	Ramos	09951234567	Seasonal	Active	E133	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E192	\N	D013	POS049	Sofia	Navarro	09181234567	Seasonal	Active	E120	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E193	\N	D003	POS050	Quentin	Soriano	09171234606	Seasonal	Active	E019	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E194	\N	D019	POS051	Rhea	Mendoza	09171234607	Seasonal	Active	\N	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E195	\N	D013	POS052	Simon	Reyes	09171234608	Seasonal	Active	E120	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E196	\N	D013	POS053	Tanya	Alonzo	09171234609	Seasonal	Active	E120	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
E197	\N	D013	POS054	Victor	Castro	09171234610	Seasonal	Active	E120	f	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: job_posting; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.job_posting (job_id, dept_id, position_id, position_title, description, requirements, employment_type, base_salary, daily_rate, duration_days, finance_approval_id, finance_approval_status, posting_status, created_at, updated_at) FROM stdin;
JOB-202504-6537	D015	POS023	Maintenance Manager	Oversee warehouse operations and manage inventory staff.	Experience in logistics, leadership skills, knowledge of inventory systems.	Regular	43000.00	\N	\N	\N	Approved	Open	2025-04-08 09:00:00	2025-04-08 09:00:00
JOB-202504-5797	D017	POS042	Graphic Designer	Assist in fieldwork and maintenance of heavy equipment.	Technical background, physical stamina, basic repair knowledge.	Contractual	\N	50.00	30	\N	Approved	Open	2025-04-08 09:15:00	2025-04-08 09:15:00
JOB-202504-0445	D009	POS055	Logistic Support	Encode survey data and perform validation tasks.	Fast typing skills, attention to detail, knowledge of MS Excel.	Seasonal	\N	25.00	15	\N	Pending	Draft	2025-04-08 09:30:00	2025-04-08 09:30:00
JOB-202504-3845	D004	POS021	Sales Manager	Analyze budget reports and assist in financial planning.	Degree in Finance or Accounting, 2+ years experience, Excel proficiency.	Regular	33000.00	\N	\N	\N	Approved	Open	2025-04-08 09:45:00	2025-04-08 09:45:00
JOB-202504-2128	D002	POS040	Marketing Assistant	Assist with document filing, onboarding, and employee support.	Good communication, organization skills, basic HR knowledge.	Contractual	\N	40.91	35	\N	Rejected	Draft	2025-04-08 10:00:00	2025-04-08 10:00:00
\.


--
-- Data for Name: leave_requests; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.leave_requests (leave_id, employee_id, dept_id, immediate_superior_id, management_approval_id, leave_type, start_date, end_date, total_days, is_paid, status, created_at, updated_at) FROM stdin;
LV-202504-858c0e	E001	D001	E002	\N	Vacation	2023-06-12	2023-06-16	5	t	Approved by Management	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
LV-202504-27bc19	E001	D001	E002	\N	Sick	2023-07-05	2023-07-05	1	t	Approved by Superior	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: payroll; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.payroll (payroll_id, employee_id, pay_period_start, pay_period_end, employment_type, base_salary, overtime_hours, overtime_pay, holiday_pay, bonus_pay, thirteenth_month_pay, sss_contribution, philhealth_contribution, pagibig_contribution, tax, late_deduction, absent_deduction, undertime_deduction, status, created_at, updated_at) FROM stdin;
PAY-202311-E001	E001	2023-11-01	2023-11-15	Regular	32500.00	4.50	2492.90	3840.91	0.00	0.00	1125.00	1300.00	100.00	3875.20	121.88	0.00	923.30	Draft	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
PAY-202311-E179	E179	2023-11-01	2023-11-15	Contractual	8100.00	2.00	506.25	0.00	0.00	0.00	1125.00	594.00	100.00	0.00	168.75	2700.00	2700.00	Draft	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
PAY-202311-E189	E189	2023-11-01	2023-11-15	Seasonal	3500.00	0.00	0.00	0.00	0.00	0.00	1125.00	308.00	100.00	0.00	0.00	1400.00	1778.88	Draft	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: positions; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.positions (position_id, position_title, salary_grade, min_salary, max_salary, employment_type, typical_duration_days, is_active, created_at, updated_at) FROM stdin;
POS001	Chief Accountant	SG-CA-3	60000.00	68000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS002	Accounting Supervisor	SG-AS-5	35000.00	38000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS003	Administrative Manager	SG-AM-4	55000.00	60000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS004	Office Administrator	SG-O6	22000.00	25000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS005	Distribution Manager	SG-DM-3	95000.00	105000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS006	Chief Financial Officer	SG-CFO-7	150000.00	170000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS007	Finance Manager	SG-FM-3	46000.00	50000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS008	HR Director	SG-HRD-9	110000.00	130000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS009	HR Manager	SG-HRM-5	64000.00	72000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS010	Inventory Manager	SG-IM-3	32000.00	38000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS011	Chief Executive Officer	SG-CEO-5	240000.00	260000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS012	Chief Operations Officer	SG-COO-3	170000.00	190000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS013	General Manager	SG-GM-6	110000.00	130000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS014	Assistant Manager	SG-AMGR-8	55000.00	65000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS015	MRP Manager	SG-MRP-1	37000.00	42000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS016	Operations Manager	SG-OM-2	85000.00	95000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS017	Production Manager	SG-PM-5	76000.00	84000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS018	Project Manager	SG-PM-6	60000.00	65000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS019	Purchasing Manager	SG-PM-7	43000.00	47000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS020	Sales Director	SG-SD-9	54000.00	58000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS021	Sales Manager	SG-SM-4	33000.00	37000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS022	Customer Service Manager	SG-CSM-6	48000.00	52000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS023	Maintenance Manager	SG-MM-6	43000.00	47000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS024	IT Manager	SG-ITM-3	70000.00	76000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS025	Network Administrator	SG-NA-8	33000.00	37000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS026	System Administrator	SG-SA-2	43000.00	47000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS027	Quality Control Inspector	SG-QCI-3	16000.00	20000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS028	HSE Manager	SG-HSEM-7	23000.00	27000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS029	Security Manager	SG-SM-6	61000.00	67000.00	Regular	\N	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS030	Project Accountant	SG-CT-01	1500.00	2000.00	Contractual	90	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS031	Inventory Specialist	SG-CT-02	1200.00	1500.00	Contractual	60	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS032	System Migration Consultant	SG-CT-03	2500.00	3000.00	Contractual	180	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS033	Audit Assistant	SG-CT-04	1300.00	1600.00	Contractual	120	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS034	Data Entry Specialist	SG-CT-05	1000.00	1200.00	Contractual	30	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS035	Marketing Assistant	SG-CT-06	800.00	1200.00	Contractual	60	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS036	Sales Promoter	SG-CT-07	515.00	700.00	Contractual	30	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS037	Graphic Designer	SG-CT-08	1100.00	1400.00	Contractual	90	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS038	Legal Consultant	SG-CT-09	500.00	700.00	Contractual	60	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS039	Company Nurse	SG-CT-10	1100.00	1400.00	Contractual	150	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS040	Marketing Assistant	SG-CT-11	900.00	1200.00	Contractual	60	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS041	Sales Promoter	SG-CT-12	500.00	700.00	Contractual	30	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS042	Graphic Designer	SG-CT-13	1100.00	1300.00	Contractual	90	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS043	Legal Consultant	SG-CT-14	500.00	700.00	Contractual	60	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS044	Company Nurse	SG-CT-15	1200.00	1400.00	Contractual	150	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS045	Holiday Sales Associate	SG-SN-01	800.00	1200.00	Seasonal	21	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS046	Tax Season Accountant	SG-SN-02	1500.00	1800.00	Seasonal	28	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS047	Summer Intern	SG-SN-03	600.00	800.00	Seasonal	14	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS048	Christmas Warehouse Helper	SG-SN-04	900.00	1100.00	Seasonal	20	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS049	New Year Event Staff	SG-SN-05	750.00	950.00	Seasonal	7	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS050	Logistic Support	SG-SN-06	500.00	750.00	Seasonal	14	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS051	Temporary Security Guard	SG-SN-07	500.00	750.00	Seasonal	7	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS052	Product Demonstrator	SG-SN-08	500.00	750.00	Seasonal	21	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS053	Promotion Staff	SG-SN-09	600.00	800.00	Seasonal	14	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS054	Product Ambassador	SG-SN-10	600.00	800.00	Seasonal	28	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS055	Logistic Support	SG-SN-11	550.00	600.00	Seasonal	14	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS056	Temporary Security Guard	SG-SN-12	550.00	600.00	Seasonal	7	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS057	Product Demonstrator	SG-SN-13	550.00	600.00	Seasonal	21	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS058	Promotion Staff	SG-SN-14	630.00	660.00	Seasonal	14	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
POS059	Product Ambassador	SG-SN-15	590.00	630.00	Seasonal	29	t	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: resignations; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.resignations (resignation_id, employee_id, submission_date, notice_period_days, hr_approver_id, approval_status, clearance_status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: workforce_allocation; Type: TABLE DATA; Schema: human_resources; Owner: postgres
--

COPY human_resources.workforce_allocation (allocation_id, request_id, requesting_dept_id, required_skills, task_description, employee_id, current_dept_id, hr_approver_id, approval_status, status, start_date, end_date, rejection_reason, submitted_at, approved_at) FROM stdin;
ALLOC-202504-9054	REQ20250408001	D002	Welding, Equipment Handling	Assist with steel frame assembly in construction site.	E004	D001	E178	Approved	Active	2025-04-10	2025-04-30	\N	2025-04-08 10:30:00	2025-04-08 14:45:00
ALLOC-202504-9634	REQ20250408002	D003	Inventory Management, Basic Accounting	Support warehouse inventory tracking and reporting.	E010	D005	E178	Pending	Draft	2025-04-12	2025-04-25	\N	2025-04-08 11:00:00	\N
ALLOC-202504-7939	REQ20250408003	D004	Machine Operation, Safety Compliance	Operate CNC machines and monitor production safety.	E019	D001	E178	Approved	Active	2025-04-15	2025-05-15	\N	2025-04-08 09:45:00	2025-04-08 13:10:00
ALLOC-202504-7485	REQ20250408004	D005	Customer Service, Communication Skills	Assist in client onboarding and inquiries handling.	E048	D002	E178	Rejected	Draft	2025-04-10	2025-04-20	Insufficient skill match.	2025-04-08 10:00:00	2025-04-08 11:15:00
ALLOC-202504-1011	REQ20250408005	D006	Data Entry, Attention to Detail	Input survey data from field agents to system.	E133	D004	E178	Approved	Active	2025-04-09	2025-04-18	\N	2025-04-08 08:30:00	2025-04-08 10:50:00
\.


--
-- Data for Name: deprecation_report; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.deprecation_report (deprecation_report_id, inventory_item_id, reported_date, deprecation_status) FROM stdin;
INV-DR-2025-4a4004	\N	2025-03-30 10:00:00	Pending
INV-DR-2025-db4b11	\N	2025-03-31 15:45:00	Approved
INV-DR-2025-f19f53	\N	2025-04-01 11:20:00	Rejected
\.


--
-- Data for Name: expiry_report; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.expiry_report (expiry_report_id, inventory_item_id, reported_date, expiry_report_status) FROM stdin;
INV-ER-2025-d86ae1	\N	2025-03-28 14:00:00	Pending
INV-ER-2025-5dd8a4	\N	2025-03-29 16:10:00	Approved
INV-ER-2025-981c16	\N	2025-04-02 09:00:00	Rejected
\.


--
-- Data for Name: inventory_adjustments; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.inventory_adjustments (adjustment_id, item_id, adjustment_type, quantity, adjustment_date, employee_id) FROM stdin;
INV-IA-2025-6a40b1	\N	Inbound	50	2025-03-15 09:00:00	\N
INV-IA-2025-f3839f	\N	Outbound-Production	20	2025-03-20 13:30:00	\N
INV-IA-2025-53c0d0	\N	Outbound-Deprecated	5	2025-03-25 08:15:00	\N
\.


--
-- Data for Name: inventory_cyclic_counts; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.inventory_cyclic_counts (inventory_count_id, inventory_item_id, item_onhand, item_actually_counted, difference_in_qty, employee_id, status, remarks, time_period, warehouse_id) FROM stdin;
INV-ICC-2025-eb32c0	\N	150	145	-5	\N	Completed	Minor discrepancy due to packaging	monthly	\N
INV-ICC-2025-cd6644	\N	80	80	0	\N	Open	Initial count for new batch	weekly	\N
INV-ICC-2025-803953	\N	5	4	-1	\N	In Progress	Under investigation	quarterly	\N
\.


--
-- Data for Name: inventory_item; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.inventory_item (inventory_item_id, serial_id, productdocu_id, material_id, asset_id, item_type, current_quantity, warehouse_id, expiry, shelf_life, last_update, date_created) FROM stdin;
INV-II-2025-722378	\N	\N	\N	\N	Raw Material	150	\N	2025-12-01 00:00:00	Depreciating	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
INV-II-2025-89a3f2	\N	\N	\N	\N	Product	80	\N	2025-06-01 00:00:00	Expiring	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
INV-II-2025-dd678a	\N	\N	\N	\N	Asset	5	\N	\N	Depreciating	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: inventory_item_threshold; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.inventory_item_threshold (inventory_item_threshold_id, item_id, minimum_threshold, maximum_threshold) FROM stdin;
INV-IITH-2025-ce8f6f	\N	100	500
INV-IITH-2025-0de9d2	\N	50	200
INV-IITH-2025-00c8f0	\N	1	10
\.


--
-- Data for Name: warehouse_movement; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.warehouse_movement (movement_id, docu_creation_date, movement_date, movement_status, destination, source, reference_id_purchase_order, reference_id_order, comments) FROM stdin;
INV-WM-2025-c33bb1	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108	Open	\N	\N	\N	\N	Transfer from receiving to main storage
INV-WM-2025-d6b414	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108	Completed	\N	\N	\N	\N	Stock reallocation
INV-WM-2025-f8aaf1	2025-04-11 23:12:09.071108	2025-04-11 23:12:09.071108	In Progress	\N	\N	\N	\N	Pending dispatch approval
\.


--
-- Data for Name: warehouse_movement_items; Type: TABLE DATA; Schema: inventory; Owner: postgres
--

COPY inventory.warehouse_movement_items (movement_id, inventory_item_id, quantity) FROM stdin;
\.


--
-- Data for Name: management_approvals; Type: TABLE DATA; Schema: management; Owner: postgres
--

COPY management.management_approvals (approval_id, request_id_all, external_id, decision_date, issue_date, checked_by, checked_date, status, due_date, remarks) FROM stdin;
MGT-2025-c533dc	\N	\N	2025-03-15	2025-03-10	\N	2025-03-20	approved	2025-03-20	Approved after review.
MGT-2025-2acf58	\N	\N	2025-03-16	2025-03-11	\N	2025-03-20	pending	2025-03-25	Pending further verification.
MGT-2025-5c5fa5	\N	\N	2025-03-17	2025-03-12	\N	2025-03-20	rejected	2025-03-18	Rejected due to incomplete documents.
MGT-2025-c4a9e8	\N	\N	2025-03-18	2025-03-14	\N	2025-03-20	approved	2025-03-22	Approved after additional checks.
MGT-2025-4e508e	\N	\N	2025-03-19	2025-03-15	\N	2025-03-20	approved	2025-03-21	Approved without issues.
MGT-2025-c916f5	\N	\N	2025-03-20	2025-03-16	\N	2025-03-20	pending	2025-03-23	Pending further information.
MGT-2025-239ad1	\N	\N	2025-03-21	2025-03-17	\N	2025-03-20	rejected	2025-03-24	Rejected due to non-compliance.
MGT-2025-7dafa9	\N	\N	2025-03-22	2025-03-18	\N	2025-03-20	approved	2025-03-26	Approved after successful review.
MGT-2025-6e3f21	\N	\N	2025-03-23	2025-03-19	\N	2025-03-20	pending	2025-03-27	Pending confirmation from department.
MGT-2025-98d769	\N	\N	2025-03-24	2025-03-20	\N	2025-03-20	approved	2025-03-28	Approved after final inspection.
\.


--
-- Data for Name: bill_of_materials; Type: TABLE DATA; Schema: mrp; Owner: postgres
--

COPY mrp.bill_of_materials (bom_id, project_id, product_mats_id, overall_quantity_of_material, cost_per_raw_material, total_cost_of_raw_materials, production_order_detail_id, labor_cost_id, total_cost) FROM stdin;
MRP-BOM-2025-1dcec3	\N	\N	500	12.50	6250.00	\N	\N	6250.00
MRP-BOM-2025-16f997	\N	\N	300	15.00	4500.00	\N	\N	4500.00
MRP-BOM-2025-041809	\N	\N	750	8.50	6375.00	\N	\N	6375.00
MRP-BOM-2025-68fcdf	\N	\N	200	20.00	4000.00	\N	\N	4000.00
MRP-BOM-2025-5f6e01	\N	\N	150	25.00	3750.00	\N	\N	3750.00
MRP-BOM-2025-6b543a	\N	\N	800	10.50	8400.00	\N	\N	8400.00
MRP-BOM-2025-90cbd6	\N	\N	1000	7.00	7000.00	\N	\N	7000.00
MRP-BOM-2025-8a7099	\N	\N	1200	5.25	6300.00	\N	\N	6300.00
MRP-BOM-2025-f971ca	\N	\N	900	11.25	10125.00	\N	\N	10125.00
MRP-BOM-2025-8fcd11	\N	\N	600	13.00	7800.00	\N	\N	7800.00
MRP-BOM-2025-0c56e5	\N	\N	450	9.75	4387.50	\N	\N	4387.50
\.


--
-- Data for Name: labor_cost; Type: TABLE DATA; Schema: mrp; Owner: postgres
--

COPY mrp.labor_cost (labor_cost_id, labor_id, salary_id) FROM stdin;
MRP-LC-2025-1ac89a	\N	\N
MRP-LC-2025-305766	\N	\N
MRP-LC-2025-c7c65b	\N	\N
MRP-LC-2025-7f3c68	\N	\N
MRP-LC-2025-e055c7	\N	\N
MRP-LC-2025-df5b9a	\N	\N
MRP-LC-2025-4b1640	\N	\N
MRP-LC-2025-58afea	\N	\N
MRP-LC-2025-44a708	\N	\N
MRP-LC-2025-180a52	\N	\N
MRP-LC-2025-8b524c	\N	\N
MRP-LC-2025-b061e6	\N	\N
MRP-LC-2025-60a441	\N	\N
\.


--
-- Data for Name: non_project_order_pricing; Type: TABLE DATA; Schema: mrp; Owner: postgres
--

COPY mrp.non_project_order_pricing (non_project_costing_id, order_id, final_price) FROM stdin;
MRP-NPC-2025-0778c0	\N	9500.00
MRP-NPC-2025-3cb699	\N	4700.00
MRP-NPC-2025-af9053	\N	19000.00
MRP-NPC-2025-a3d8b8	\N	14000.00
MRP-NPC-2025-c21842	\N	7100.00
MRP-NPC-2025-ef877d	\N	23500.00
MRP-NPC-2025-8efef6	\N	16625.00
MRP-NPC-2025-0783cd	\N	7600.00
MRP-NPC-2025-23c1b7	\N	11875.00
MRP-NPC-2025-729c7a	\N	5700.00
MRP-NPC-2025-14ac72	\N	17100.00
MRP-NPC-2025-579b23	SALES-ORD-2025-c2f3ab	0.00
MRP-NPC-2025-04cb60	SALES-ORD-2025-441037	0.00
MRP-NPC-2025-9a4c16	SALES-ORD-2025-72a45f	0.00
MRP-NPC-2025-377efb	SALES-ORD-2025-4b3677	0.00
MRP-NPC-2025-889033	SALES-ORD-2025-53a470	0.00
MRP-NPC-2025-ed9a6a	SALES-ORD-2025-6484c7	0.00
MRP-NPC-2025-d0a0bd	SALES-ORD-2025-d3e940	0.00
MRP-NPC-2025-70777f	SALES-ORD-2025-de59c9	0.00
MRP-NPC-2025-babf80	SALES-ORD-2025-a07f25	0.00
MRP-NPC-2025-cc7a60	SALES-ORD-2025-f9be31	0.00
MRP-NPC-2025-d92710	SALES-ORD-2025-3e12b5	0.00
MRP-NPC-2025-c93ab5	SALES-ORD-2025-172658	0.00
\.


--
-- Data for Name: principal_items; Type: TABLE DATA; Schema: mrp; Owner: postgres
--

COPY mrp.principal_items (principal_item_id, service_order_item_id, item_id, mark_up_price) FROM stdin;
MRP-PI-2025-6da037	\N	\N	120.00
MRP-PI-2025-729ed5	\N	\N	96.00
MRP-PI-2025-e34dad	\N	\N	66.00
MRP-PI-2025-d1f42b	\N	\N	180.00
MRP-PI-2025-71e388	\N	\N	240.00
MRP-PI-2025-23e21d	\N	\N	132.00
MRP-PI-2025-a9b503	\N	\N	150.00
MRP-PI-2025-c7887c	\N	\N	90.00
MRP-PI-2025-49d447	\N	\N	72.00
MRP-PI-2025-180881	\N	\N	156.00
\.


--
-- Data for Name: product_mats; Type: TABLE DATA; Schema: mrp; Owner: postgres
--

COPY mrp.product_mats (product_mats_id, product_id, material_id, quantity_required, cost_of_used_materials) FROM stdin;
MRP-PM-2025-f3525d	\N	\N	25.00	2.50
MRP-PM-2025-983ca1	\N	\N	10.00	1.50
MRP-PM-2025-8c6bed	\N	\N	15.00	12.00
MRP-PM-2025-d633e5	\N	\N	30.00	2.25
MRP-PM-2025-1c8590	\N	\N	50.00	0.80
MRP-PM-2025-1a6418	\N	\N	40.00	5.00
MRP-PM-2025-bec5a0	\N	\N	100.00	0.99
MRP-PM-2025-eae449	\N	\N	60.00	8.25
MRP-PM-2025-401744	\N	\N	80.00	3.75
MRP-PM-2025-6c31b9	\N	\N	200.00	0.45
\.


--
-- Data for Name: document_header; Type: TABLE DATA; Schema: operations; Owner: postgres
--

COPY operations.document_header (document_id, document_type, vendor_code, document_no, transaction_id, content_id, invoice_id, ar_credit_memo, status, posting_date, delivery_date, document_date, buyer, employee_id, initial_amount, discount_rate, discount_amount, freight, tax_rate, tax_amount, transaction_cost) FROM stdin;
OPS-DOH-2025-f7496d	Goods Receipt PO	\N	1001	2001	\N	\N	ARC20250411-0001	Open	2025-01-01	2025-01-05	2025-01-01	Alice Johnson	\N	5000.00	5.00	250.00	100.00	10.00	500.00	150.00
OPS-DOH-2025-928ab6	Goods Issue	\N	1003	2003	\N	\N	ARC20250411-0002	Cancelled	2025-01-03	2025-01-07	2025-01-03	Ethan Wright	\N	3000.00	4.50	135.00	90.00	8.50	255.00	100.00
OPS-DOH-2025-5d0880	A/R Credit Memo	\N	1004	2004	\N	\N	ARC20250411-0003	Open	2025-01-04	2025-01-08	2025-01-04	Maya Collins	\N	4600.00	5.25	241.50	92.00	9.00	414.00	135.00
OPS-DOH-2025-f098d1	Goods Receipt	\N	1005	2005	\N	\N	ARC20250411-0004	Open	2025-01-05	2025-01-09	2025-01-05	Isaac Clark	\N	6000.00	5.50	330.00	105.00	11.00	660.00	160.00
OPS-DOH-2025-302e76	Goods Receipt PO	\N	1006	2006	\N	\N	ARC20250411-0005	Closed	2025-01-06	2025-01-10	2025-01-06	Kevin Brown	\N	8000.00	6.50	520.00	130.00	12.50	1000.00	190.00
OPS-DOH-2025-6d5654	Goods Issue	\N	1008	2008	\N	\N	ARC20250411-0006	Draft	2025-01-08	2025-01-12	2025-01-08	Oliver Scott	\N	5500.00	5.25	288.75	95.00	9.75	536.25	145.00
OPS-DOH-2025-380549	A/R Credit Memo	\N	1009	2009	\N	\N	ARC20250411-0007	Open	2025-01-09	2025-01-13	2025-01-09	Grace White	\N	4500.00	5.00	225.00	90.00	9.00	405.00	130.00
OPS-DOH-2025-17045a	Goods Receipt	\N	1010	2010	\N	\N	ARC20250411-0008	Closed	2025-01-10	2025-01-14	2025-01-10	Samuel Carter	\N	7200.00	6.25	450.00	125.00	10.50	756.00	170.00
OPS-DOH-2025-5fd618	Goods Receipt PO	\N	1011	2011	\N	\N	ARC20250411-0009	Open	2025-01-11	2025-01-15	2025-01-11	Ursula Lane	\N	6300.00	5.75	362.25	110.00	10.25	645.75	165.00
OPS-DOH-2025-4f2b69	Goods Issue	\N	1012	2012	\N	\N	ARC20250411-0010	Closed	2025-01-12	2025-01-16	2025-01-12	Walter Perry	\N	4800.00	5.00	240.00	108.00	9.50	456.00	140.00
OPS-DOH-2025-ecaa2b	A/R Credit Memo	\N	1013	2013	\N	\N	ARC20250411-0011	Draft	2025-01-13	2025-01-17	2025-01-13	Yvonne Blake	\N	4100.00	4.75	194.75	85.00	8.75	369.00	120.00
OPS-DOH-2025-c2220e	Goods Receipt	\N	1014	2014	\N	\N	ARC20250411-0012	Draft	2025-01-14	2025-01-18	2025-01-14	Adam Reed	\N	5700.00	5.00	285.00	103.00	9.75	555.75	155.00
OPS-DOH-2025-dd272d	Goods Receipt PO	\N	1016	2016	\N	\N	ARC20250411-0013	Open	2025-01-16	2025-01-20	2025-01-16	Ella Grant	\N	6900.00	6.00	414.00	120.00	11.00	759.00	180.00
OPS-DOH-2025-05f5b1	A/R Credit Memo	\N	1016	2016	\N	\N	ARC20250411-0014	Cancelled	2025-01-16	2025-01-20	2025-01-16	Dean Marcus	\N	3700.00	4.50	166.50	78.00	8.25	333.00	100.00
OPS-DOH-2025-b36872	Goods Issue	\N	1017	2017	\N	\N	ARC20250411-0015	Open	2025-01-17	2025-01-21	2025-01-17	Grace Hunter	\N	5100.00	5.50	280.50	107.00	9.50	484.50	145.00
OPS-DOH-2025-1bf965	Goods Receipt	\N	1019	2019	\N	\N	ARC20250411-0016	Draft	2025-01-19	2025-01-23	2025-01-19	Karen Patel	\N	6100.00	5.75	350.75	115.00	10.50	640.50	165.00
OPS-DOH-2025-877fb6	A/R Credit Memo	\N	1020	2020	\N	\N	ARC20250411-0017	Closed	2025-01-20	2025-01-24	2025-01-20	Henry James	\N	3900.00	4.50	175.50	80.00	8.50	351.00	110.00
OPS-DOH-2025-6fc9da	Goods Receipt PO	\N	1021	2021	\N	\N	ARC20250411-0018	Closed	2025-01-21	2025-01-25	2025-01-21	Liam Foster	\N	7200.00	6.00	432.00	125.00	11.50	828.00	185.00
OPS-DOH-2025-bb961b	Goods Issue	\N	1022	2022	\N	\N	ARC20250411-0019	Draft	2025-01-22	2025-01-26	2025-01-22	Nina Carter	\N	4600.00	4.75	218.50	98.00	9.00	414.00	135.00
OPS-DOH-2025-275cf2	A/R Credit Memo	\N	1023	2023	\N	\N	ARC20250411-0020	Draft	2025-01-23	2025-01-27	2025-01-23	James Nolan	\N	4800.00	5.00	240.00	100.00	9.50	456.00	140.00
OPS-DOH-2025-f36eb8	Goods Receipt	\N	1026	2026	\N	\N	ARC20250411-0021	Draft	2025-01-26	2025-01-30	2025-01-26	Rebecca Moore	\N	6100.00	5.50	335.50	112.00	10.50	640.50	165.00
\.


--
-- Data for Name: document_items; Type: TABLE DATA; Schema: operations; Owner: postgres
--

COPY operations.document_items (content_id, asset_id, document_id, material_id, serial_id, productdocu_id, external_id, delivery_request_id, request_date, quantity, total, batch_no, warehouse_id, cost, delivery_type, receiving_module, status) FROM stdin;
OPS-DOI-2025-672cc2	\N	\N	\N	\N	\N	\N	DR001	2025-01-01	10	100.00	BN20250411-0001	\N	50.00	Material Request	Production	Pending
OPS-DOI-2025-0f5ded	\N	\N	\N	\N	\N	\N	DR002	2025-01-02	15	150.00	BN20250411-0002	\N	75.00	Finished Goods Request	Inventory	Approved
OPS-DOI-2025-097dcd	\N	\N	\N	\N	\N	\N	DR003	2025-01-03	20	200.00	BN20250411-0003	\N	100.00	Material Request	Production	Rejected
OPS-DOI-2025-01a38f	\N	\N	\N	\N	\N	\N	DR004	2025-01-04	25	250.00	BN20250411-0004	\N	125.00	Finished Goods Request	Inventory	Pending
OPS-DOI-2025-eae8d2	\N	\N	\N	\N	\N	\N	DR005	2025-01-05	30	300.00	BN20250411-0005	\N	150.00	Material Request	Production	Approved
OPS-DOI-2025-617f63	\N	\N	\N	\N	\N	\N	DR006	2025-01-06	18	180.00	BN20250411-0006	\N	90.00	Finished Goods Request	Inventory	Rejected
OPS-DOI-2025-b5fa14	\N	\N	\N	\N	\N	\N	DR007	2025-01-07	12	120.00	BN20250411-0007	\N	60.00	Material Request	Production	Pending
OPS-DOI-2025-66aa48	\N	\N	\N	\N	\N	\N	DR008	2025-01-08	22	220.00	BN20250411-0008	\N	110.00	Finished Goods Request	Inventory	Approved
OPS-DOI-2025-50b1a2	\N	\N	\N	\N	\N	\N	DR009	2025-01-09	28	280.00	BN20250411-0009	\N	140.00	Material Request	Production	Rejected
OPS-DOI-2025-788396	\N	\N	\N	\N	\N	\N	DR010	2025-01-10	32	320.00	BN20250411-0010	\N	160.00	Finished Goods Request	Inventory	Pending
OPS-DOI-2025-6cab6f	\N	\N	\N	\N	\N	\N	DR011	2025-01-11	14	140.00	BN20250411-0011	\N	70.00	Material Request	Production	Approved
OPS-DOI-2025-1e33ae	\N	\N	\N	\N	\N	\N	DR012	2025-01-12	26	260.00	BN20250411-0012	\N	130.00	Finished Goods Request	Inventory	Rejected
OPS-DOI-2025-1a3b78	\N	\N	\N	\N	\N	\N	DR013	2025-01-13	19	190.00	BN20250411-0013	\N	95.00	Material Request	Production	Pending
OPS-DOI-2025-d22e80	\N	\N	\N	\N	\N	\N	DR014	2025-01-14	35	350.00	BN20250411-0014	\N	175.00	Finished Goods Request	Inventory	Approved
OPS-DOI-2025-63a69d	\N	\N	\N	\N	\N	\N	DR015	2025-01-15	40	400.00	BN20250411-0015	\N	200.00	Material Request	Production	Rejected
OPS-DOI-2025-f9b7ec	\N	\N	\N	\N	\N	\N	DR016	2025-01-16	16	160.00	BN20250411-0016	\N	80.00	Finished Goods Request	Inventory	Pending
OPS-DOI-2025-6b07b6	\N	\N	\N	\N	\N	\N	DR017	2025-01-17	21	210.00	BN20250411-0017	\N	105.00	Material Request	Production	Approved
OPS-DOI-2025-9295ec	\N	\N	\N	\N	\N	\N	DR018	2025-01-18	29	290.00	BN20250411-0018	\N	145.00	Finished Goods Request	Inventory	Rejected
OPS-DOI-2025-553628	\N	\N	\N	\N	\N	\N	DR019	2025-01-19	33	330.00	BN20250411-0019	\N	165.00	Material Request	Production	Pending
OPS-DOI-2025-a37174	\N	\N	\N	\N	\N	\N	DR020	2025-01-20	24	240.00	BN20250411-0020	\N	120.00	Finished Goods Request	Inventory	Approved
\.


--
-- Data for Name: external_module; Type: TABLE DATA; Schema: operations; Owner: postgres
--

COPY operations.external_module (external_id, content_id, purchase_id, request_id, approval_id, goods_issue_id, approval_request_id, billing_receipt_id, delivery_receipt_id, project_resources_id, project_tracking_id, project_request_id, production_order_detail_id, rework_id, deprecation_report_id, rework_quantity, reason_rework) FROM stdin;
OPS-EXM-2025-ce76c8	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5	Incorrect specifications
OPS-EXM-2025-995790	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3	Damaged parts
OPS-EXM-2025-f053a1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-69e135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	Assembly error
OPS-EXM-2025-ace4c4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-4f6b67	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4	Welding issue
OPS-EXM-2025-c14606	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1	Surface defect
OPS-EXM-2025-7f22f2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-42605e	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3	Paint inconsistency
OPS-EXM-2025-182cd5	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-9820e4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	6	Incorrect dimensions
OPS-EXM-2025-622fa7	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-73f05f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2	Packaging damage
OPS-EXM-2025-208acb	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-8ade8b	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	7	Calibration issue
OPS-EXM-2025-73923d	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-c7dd79	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1	Threading error
OPS-EXM-2025-1a8741	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
OPS-EXM-2025-5c541c	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5	Component mismatch
OPS-EXM-2025-9a4a42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	\N
\.


--
-- Data for Name: product_document_items; Type: TABLE DATA; Schema: operations; Owner: postgres
--

COPY operations.product_document_items (productdocu_id, product_id, manuf_date, expiry_date, content_id) FROM stdin;
OPS-PDI-2025-6be8a6	\N	2024-01-01	2026-01-01	\N
OPS-PDI-2025-e449dc	\N	2024-02-01	2026-02-01	\N
OPS-PDI-2025-bc64b7	\N	2024-03-01	2026-03-01	\N
OPS-PDI-2025-a5f0a1	\N	2024-04-01	2026-04-01	\N
OPS-PDI-2025-78f2c9	\N	2024-05-01	2026-05-01	\N
OPS-PDI-2025-98ada8	\N	2024-06-01	2026-06-01	\N
OPS-PDI-2025-4f809b	\N	2024-07-01	2026-07-01	\N
OPS-PDI-2025-0244ad	\N	2024-08-01	2026-08-01	\N
OPS-PDI-2025-a4400f	\N	2024-09-01	2026-09-01	\N
OPS-PDI-2025-7c1faf	\N	2024-10-01	2026-10-01	\N
OPS-PDI-2025-1cffd8	\N	2024-11-01	2026-11-01	\N
OPS-PDI-2025-79d294	\N	2024-12-01	2026-12-01	\N
OPS-PDI-2025-e3ae2b	\N	2025-01-01	2027-01-01	\N
OPS-PDI-2025-ff21a5	\N	2025-02-01	2027-02-01	\N
OPS-PDI-2025-e6a393	\N	2025-03-01	2027-03-01	\N
OPS-PDI-2025-0e4e1b	\N	2025-04-01	2027-04-01	\N
OPS-PDI-2025-958815	\N	2025-05-01	2027-05-01	\N
OPS-PDI-2025-9aa99f	\N	2025-06-01	2027-06-01	\N
OPS-PDI-2025-c133a0	\N	2025-07-01	2027-07-01	\N
OPS-PDI-2025-7f8a81	\N	2025-08-01	2027-08-01	\N
\.


--
-- Data for Name: serial_tracking; Type: TABLE DATA; Schema: operations; Owner: postgres
--

COPY operations.serial_tracking (serial_id, document_id, serial_no) FROM stdin;
OPS-SET-2025-90e53a	\N	KNTP0001
OPS-SET-2025-2a62af	\N	KNTP0002
OPS-SET-2025-61dc94	\N	KNTP0003
OPS-SET-2025-5dcad6	\N	KNTP0004
OPS-SET-2025-305469	\N	KNTP0005
OPS-SET-2025-b2ce67	\N	KNTP0006
OPS-SET-2025-73e770	\N	KNTP0007
OPS-SET-2025-c234c4	\N	KNTP0008
OPS-SET-2025-07f404	\N	KNTP0009
OPS-SET-2025-60844b	\N	KNTP0010
OPS-SET-2025-704544	\N	KNTP0011
OPS-SET-2025-ea3688	\N	KNTP0012
OPS-SET-2025-c8147b	\N	KNTP0013
OPS-SET-2025-d3e859	\N	KNTP0014
OPS-SET-2025-68fd69	\N	KNTP0015
OPS-SET-2025-07269e	\N	KNTP0016
OPS-SET-2025-058787	\N	KNTP0017
OPS-SET-2025-78fe9d	\N	KNTP0018
OPS-SET-2025-537899	\N	KNTP0019
OPS-SET-2025-3f9c47	\N	KNTP0020
\.


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.equipment (equipment_id, equipment_name, description, availability_status, last_maintenance_date, equipment_cost) FROM stdin;
PROD-EQP-2025-d360ba	CNC Milling Machine (5-axis)	High-precision 5 axis CNC milling machine for complex metal parts with intricate geometries	Available	2025-04-11	750000.00
PROD-EQP-2025-21a31d	Laser Cutting & Engraving Machine	CO2 laser cutter and engraver for precise cutting and marking of various materials, including metals, plastics, and wood	Under Maintenance	2025-04-11	350000.00
PROD-EQP-2025-10a939	Industrial 3D Printer (SLA)	Stereolithography (SLA) 3D printer for high-resolution prototypes and custom parts with fine details and smooth surfaces	Available	2025-04-11	450000.00
PROD-EQP-2025-bdf8fc	Welding Station	Multi-process welding station with MIG, TIG, and stick welding capabilities	Available	2025-04-11	80000.00
PROD-EQP-2025-fee82f	Paint Booth	Enclosed paint booth with ventilation system for applying custom finishes	Available	2025-04-11	150000.00
PROD-EQP-2025-ea3f77	Industrial Sewing Machine	Heavy-duty sewing machine for various fabrics and materials	Available	2025-04-11	30000.00
PROD-EQP-2025-8dbb53	Pick and Place Machine	Automated pick and place machine for precise placement of electronic components on printed circuit boards (PCBs)	Available	2025-04-11	600000.00
PROD-EQP-2025-c27cb4	Reflow Oven	Reflow oven for soldering electronic components to PCBs	Available	2024-03-05	200000.00
PROD-EQP-2025-6ae095	Optical Inspection (AOI) Machine	AOI machine for visual inspection of PCBs for defects and quality control	Available	2025-04-11	400000.00
PROD-EQP-2025-dd9d7e	Wave Soldering Machine	Wave soldering machine for soldering through-hole components to PCBs	Out of Order	2025-04-11	250000.00
PROD-EQP-2025-f4bfa7	Molding Machine	A machine for molding plastic components for medical devices	Available	2025-04-11	380000.00
PROD-EQP-2025-560e78	Precision Grinding Machine	Grinding machine for shaping metal parts to precise dimensions	Available	2025-04-11	220000.00
PROD-EQP-2025-239bce	Robotic Assembly Arm	Robotic arm for precise and repetitive assembly of medical device components	Available	2025-04-11	550000.00
PROD-EQP-2025-842d30	Cleanroom Injection Molder	Injection molding machine designed for cleanroom environments	Under Maintenance	2025-04-11	800000.00
PROD-EQP-2025-9b4465	Dispensing System	System for precise dispensing of adhesives and other fluids in medical device manufacturing	Available	2025-04-11	180000.00
PROD-EQP-2025-f2aca3	Wire EDM Machine	Electrical discharge machine for cutting intricate shapes in conductive materials	Available	2025-04-11	480000.00
PROD-EQP-2025-fc095f	Precision Stamping Press	Stamping press for forming sheet metal components with high accuracy	Available	2025-04-11	200000.00
PROD-EQP-2025-26e416	Automated Labeling Machine	Machine for automated labeling of medical devices and components	Available	2025-04-11	60000.00
PROD-EQP-2025-ad1ee5	Ultrasonic Cleaner	Industrial ultrasonic cleaner for cleaning medical device components	Available	2025-04-11	20000.00
PROD-EQP-2025-f069b7	Automated Cutting Machine	Automated machine for cutting materials like tubing and fabrics to precise lengths	Available	2025-04-11	120000.00
\.


--
-- Data for Name: labor; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.labor (labor_id, production_order_id, employee_id, date_worked, days_worked) FROM stdin;
PROD-LAB-2025-0675d2	\N	\N	2024-03-05 13:00:00	8
PROD-LAB-2025-3bd252	\N	\N	2024-03-06 12:00:00	7
PROD-LAB-2025-e20188	\N	\N	2024-03-10 12:30:00	6
PROD-LAB-2025-10d81c	\N	\N	2024-03-11 13:00:00	5
PROD-LAB-2025-25e8f8	\N	\N	2024-03-15 11:00:00	4
PROD-LAB-2025-0ca0f9	\N	\N	2024-04-01 11:00:00	7
PROD-LAB-2025-6f1814	\N	\N	2024-04-05 10:30:00	6
PROD-LAB-2025-811d89	\N	\N	2024-04-10 10:00:00	5
PROD-LAB-2025-73229b	\N	\N	2024-04-15 11:00:00	8
PROD-LAB-2025-694889	\N	\N	2024-04-20 11:00:00	7
PROD-LAB-2025-12b48a	\N	\N	2024-04-25 09:00:00	6
PROD-LAB-2025-cbf23a	\N	\N	2024-04-30 14:00:00	8
PROD-LAB-2025-6580c7	\N	\N	2024-05-05 10:00:00	7
PROD-LAB-2025-ed720e	\N	\N	2024-05-10 13:30:00	5
PROD-LAB-2025-0b17d8	\N	\N	2024-05-15 08:00:00	9
PROD-LAB-2025-bb34f8	\N	\N	2024-05-20 15:00:00	7
PROD-LAB-2025-2959fb	\N	\N	2024-05-25 11:00:00	6
PROD-LAB-2025-25ed0d	\N	\N	2024-05-30 09:00:00	4
PROD-LAB-2025-ffff30	\N	\N	2024-06-05 14:00:00	7
PROD-LAB-2025-7565fe	\N	\N	2024-06-10 12:00:00	6
\.


--
-- Data for Name: production_orders_details; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.production_orders_details (production_order_detail_id, production_order_id, actual_quantity, cost_of_production, miscellaneous_costs, equipment_id, rework_required, rework_notes, external_id) FROM stdin;
PROD-POD-2025-35f1db	\N	10	1500.00	50.00	\N	f	\N	\N
PROD-POD-2025-23c976	\N	5	800.00	20.00	\N	t	Minor adjustments needed due to tube leaks	\N
PROD-POD-2025-ba87e2	\N	20	800.00	60.00	\N	f	\N	\N
PROD-POD-2025-d3ce49	\N	8	1200.00	30.00	\N	f	\N	\N
PROD-POD-2025-bcf473	\N	16	1800.00	100.00	\N	f	\N	\N
PROD-POD-2025-006035	\N	12	900.00	40.00	\N	f	\N	\N
PROD-POD-2025-98d9a4	\N	25	1100.00	70.00	\N	t	CNC slot: Too narrow, card wont fit. Re-mill.	\N
PROD-POD-2025-7e994b	\N	15	1600.00	80.00	\N	f	\N	\N
PROD-POD-2025-74bbae	\N	30	2000.00	120.00	\N	f	\N	\N
PROD-POD-2025-c827d9	\N	20	1300.00	90.00	\N	f	\N	\N
PROD-POD-2025-50da8a	\N	18	2500.00	150.00	\N	f	\N	\N
PROD-POD-2025-7216c6	\N	10	1200.00	80.00	\N	t	Welded bracket: Angled wrong, attachment issue. Realign/weld.	\N
PROD-POD-2025-05ec56	\N	22	1800.00	110.00	\N	f	\N	\N
PROD-POD-2025-e68c16	\N	12	1000.00	60.00	\N	f	\N	\N
PROD-POD-2025-c50007	\N	20	2200.00	140.00	\N	f	\N	\N
PROD-POD-2025-21a09d	\N	15	1400.00	90.00	\N	t	Re-assembly required for one unit	\N
PROD-POD-2025-86e8ea	\N	28	3000.00	180.00	\N	f	\N	\N
PROD-POD-2025-deee0d	\N	18	2000.00	130.00	\N	f	\N	\N
PROD-POD-2025-d10ac6	\N	35	2800.00	170.00	\N	f	\N	\N
PROD-POD-2025-4a295a	\N	25	1700.00	100.00	\N	t	Welded frame: Incomplete weld, structural issue. Re-weld.	\N
\.


--
-- Data for Name: production_orders_header; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.production_orders_header (production_order_id, task_id, bom_id, start_date, end_date, status, target_quantity, notes) FROM stdin;
PROD-PO-2025-2c1863	\N	\N	2024-03-05 09:00:00	2024-03-15 17:00:00	Completed	10	Custom metal bed
PROD-PO-2025-aa3e1a	\N	\N	2024-03-10 10:00:00	2024-03-22 16:00:00	In Progress	5	Plastic tubes components
PROD-PO-2025-e33c3a	\N	\N	2024-03-15 11:00:00	2024-04-05 15:00:00	Pending	20	Laser-cut panels for Project Gamma
PROD-PO-2025-f77e48	\N	\N	2024-03-20 13:00:00	2024-03-28 17:00:00	Completed	8	Custom welded frame for Project Delta
PROD-PO-2025-dcd98d	\N	\N	2024-03-25 08:00:00	2024-04-10 16:00:00	In Progress	16	Custom painted casings for Project Epsilon
PROD-PO-2025-a33ea2	\N	\N	2024-04-01 14:00:00	2024-04-12 10:00:00	Pending	12	Wooden display stands
PROD-PO-2025-f34c4c	\N	\N	2024-04-05 09:00:00	2024-04-18 17:00:00	Completed	25	3D printed components for drone
PROD-PO-2025-b81641	\N	\N	2024-04-10 10:00:00	2024-04-25 16:00:00	In Progress	15	Custom copper wiring for electronics
PROD-PO-2025-c7c4b8	\N	\N	2024-04-15 11:00:00	2024-05-02 15:00:00	Pending	30	Painted metal casings for machinery
PROD-PO-2025-4f0c4a	\N	\N	2024-04-20 13:00:00	2024-04-30 17:00:00	Completed	20	Assembled electronic kits
PROD-PO-2025-2d7342	\N	\N	2024-04-25 08:00:00	2024-05-05 17:00:00	Pending	18	Assembly of surgical tool
PROD-PO-2025-610b28	\N	\N	2024-04-30 10:00:00	2024-05-12 16:00:00	In Progress	10	Production of diagnostic device
PROD-PO-2025-81e1f9	\N	\N	2024-05-05 11:00:00	2024-05-20 15:00:00	Pending	22	Manufacturing of patient monitor
PROD-PO-2025-e63820	\N	\N	2024-05-10 13:00:00	2024-05-25 17:00:00	Completed	12	Fabrication of medical cart
PROD-PO-2025-cb03cf	\N	\N	2024-05-15 08:00:00	2024-06-01 16:00:00	In Progress	20	Production of infusion pump
PROD-PO-2025-2033a3	\N	\N	2024-05-20 14:00:00	2024-06-05 10:00:00	Pending	15	Assembly of patient handling equipment
PROD-PO-2025-d5501c	\N	\N	2024-05-25 09:00:00	2024-06-10 17:00:00	Completed	28	Manufacturing of surgical robot arm
PROD-PO-2025-608beb	\N	\N	2024-05-30 10:00:00	2024-06-15 16:00:00	In Progress	18	Production of medical imaging system
PROD-PO-2025-e1e6e5	\N	\N	2024-06-05 11:00:00	2024-06-22 15:00:00	Pending	35	Fabrication of hospital bed frames
PROD-PO-2025-3ab946	\N	\N	2024-06-10 13:00:00	2024-06-30 17:00:00	Completed	25	Assembly of surgical equipment
\.


--
-- Data for Name: project_equipment; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.project_equipment (project_equipment_id, equipment_id, product_id) FROM stdin;
PROD-PJEQ-2025-bab513	\N	\N
PROD-PJEQ-2025-1e12cb	\N	\N
PROD-PJEQ-2025-583371	\N	\N
PROD-PJEQ-2025-a0d340	\N	\N
PROD-PJEQ-2025-835ab5	\N	\N
PROD-PJEQ-2025-8b1d49	\N	\N
PROD-PJEQ-2025-7949ea	\N	\N
PROD-PJEQ-2025-ff8714	\N	\N
PROD-PJEQ-2025-940833	\N	\N
PROD-PJEQ-2025-7387a4	\N	\N
PROD-PJEQ-2025-ac40a3	\N	\N
PROD-PJEQ-2025-94fa1d	\N	\N
PROD-PJEQ-2025-98d5e8	\N	\N
PROD-PJEQ-2025-dd94fc	\N	\N
PROD-PJEQ-2025-fe6631	\N	\N
PROD-PJEQ-2025-d8b21a	\N	\N
PROD-PJEQ-2025-967005	\N	\N
PROD-PJEQ-2025-b8c746	\N	\N
PROD-PJEQ-2025-a0016c	\N	\N
PROD-PJEQ-2025-1448e3	\N	\N
\.


--
-- Data for Name: rework_cost; Type: TABLE DATA; Schema: production; Owner: postgres
--

COPY production.rework_cost (rework_cost_id, production_order_id, additional_cost, additional_misc, total_rework_cost) FROM stdin;
PROD-RWC-2025-ae321e	\N	65.75	12.50	78.25
PROD-RWC-2025-0b0948	\N	38.20	7.00	45.20
PROD-RWC-2025-ea40c1	\N	72.90	14.00	86.90
PROD-RWC-2025-7fc1b6	\N	29.95	5.50	35.45
PROD-RWC-2025-1077dc	\N	52.60	9.50	62.10
PROD-RWC-2025-93547d	\N	61.15	11.00	72.15
PROD-RWC-2025-2d21e5	\N	33.50	6.50	40.00
PROD-RWC-2025-0d24e2	\N	91.80	19.00	110.80
PROD-RWC-2025-2a14bd	\N	39.65	7.00	46.65
PROD-RWC-2025-4a5aa0	\N	63.10	12.00	75.10
PROD-RWC-2025-000a90	\N	49.50	9.00	58.50
PROD-RWC-2025-cfdc0d	\N	41.60	10.00	51.60
PROD-RWC-2025-4a01f1	\N	84.90	17.50	102.40
PROD-RWC-2025-0ee92f	\N	72.90	14.00	86.90
PROD-RWC-2025-8f468a	\N	28.70	6.00	34.70
PROD-RWC-2025-b94c5d	\N	38.20	8.00	46.20
PROD-RWC-2025-3431eb	\N	22.50	5.50	28.00
PROD-RWC-2025-d34366	\N	101.75	20.50	122.25
PROD-RWC-2025-4a2555	\N	45.90	7.50	53.40
PROD-RWC-2025-a8c5b5	\N	31.00	4.50	35.50
\.


--
-- Data for Name: external_project_cost_management; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_cost_management (project_resources_id, project_id, bom_id, project_budget_approval) FROM stdin;
PROJ-EPRM-2025-a19747	\N	\N	approved
PROJ-EPRM-2025-14ca10	\N	\N	approved
PROJ-EPRM-2025-92767a	\N	\N	denied
PROJ-EPRM-2025-222372	\N	\N	approved
PROJ-EPRM-2025-d92a89	\N	\N	approved
PROJ-EPRM-2025-ef9785	\N	\N	denied
PROJ-EPRM-2025-743254	\N	\N	approved
PROJ-EPRM-2025-3ed844	\N	\N	approved
PROJ-EPRM-2025-37c628	\N	\N	denied
PROJ-EPRM-2025-90f065	\N	\N	approved
PROJ-EPRM-2025-e5332f	\N	\N	approved
PROJ-EPRM-2025-e5edc5	\N	\N	approved
PROJ-EPRM-2025-a9aafa	\N	\N	denied
PROJ-EPRM-2025-b9d599	\N	\N	approved
PROJ-EPRM-2025-85e8cd	\N	\N	approved
PROJ-EPRM-2025-d07fd2	\N	\N	denied
PROJ-EPRM-2025-032187	\N	\N	approved
PROJ-EPRM-2025-ba2aac	\N	\N	approved
PROJ-EPRM-2025-6f5309	\N	\N	denied
PROJ-EPRM-2025-1184bf	\N	\N	approved
\.


--
-- Data for Name: external_project_details; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_details (project_id, ext_project_request_id, project_status) FROM stdin;
PROJ-EPD-2025-27fafe	\N	not started
PROJ-EPD-2025-9b1206	\N	in progress
PROJ-EPD-2025-7b1539	\N	completed
PROJ-EPD-2025-07ef64	\N	in progress
PROJ-EPD-2025-948ebd	\N	not started
PROJ-EPD-2025-596a64	\N	completed
PROJ-EPD-2025-3fec46	\N	in progress
PROJ-EPD-2025-e1bcea	\N	not started
PROJ-EPD-2025-7d1a4d	\N	completed
PROJ-EPD-2025-10f73a	\N	in progress
PROJ-EPD-2025-deb929	\N	not started
PROJ-EPD-2025-2d5cc0	\N	in progress
PROJ-EPD-2025-c5a304	\N	completed
PROJ-EPD-2025-808ae3	\N	in progress
PROJ-EPD-2025-100530	\N	not started
PROJ-EPD-2025-dc1353	\N	completed
PROJ-EPD-2025-da832c	\N	in progress
PROJ-EPD-2025-a94b31	\N	not started
PROJ-EPD-2025-f26e82	\N	completed
PROJ-EPD-2025-e6df30	\N	in progress
\.


--
-- Data for Name: external_project_equipments; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_equipments (project_equipment_list_id, project_id, project_equipment_id) FROM stdin;
PROJ-EPE-2025-9a68b2	\N	\N
PROJ-EPE-2025-17e2af	\N	\N
PROJ-EPE-2025-2c41d1	\N	\N
PROJ-EPE-2025-4ed920	\N	\N
PROJ-EPE-2025-da63c3	\N	\N
PROJ-EPE-2025-f19c5a	\N	\N
PROJ-EPE-2025-f772a1	\N	\N
PROJ-EPE-2025-685ed1	\N	\N
PROJ-EPE-2025-8c9560	\N	\N
PROJ-EPE-2025-a7fe45	\N	\N
PROJ-EPE-2025-cf646f	\N	\N
PROJ-EPE-2025-5a475f	\N	\N
PROJ-EPE-2025-a73397	\N	\N
PROJ-EPE-2025-c5eaf6	\N	\N
PROJ-EPE-2025-388049	\N	\N
PROJ-EPE-2025-23937d	\N	\N
PROJ-EPE-2025-37770a	\N	\N
PROJ-EPE-2025-97ccdb	\N	\N
PROJ-EPE-2025-a451d8	\N	\N
PROJ-EPE-2025-ed7bb0	\N	\N
\.


--
-- Data for Name: external_project_labor; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_labor (project_labor_id, project_id, job_role_needed, employee_id) FROM stdin;
PROJ-EPL-2025-e87d8b	\N	Project Manager	\N
PROJ-EPL-2025-090398	\N	Project Manager	\N
PROJ-EPL-2025-a1c149	\N	Project Manager	\N
PROJ-EPL-2025-1272cb	\N	Project Manager	\N
PROJ-EPL-2025-2aad4c	\N	Regulatory Compliance Specialist	\N
PROJ-EPL-2025-ef0a04	\N	Product Customization Engineer	\N
PROJ-EPL-2025-b3fb03	\N	Product Customization Engineer	\N
PROJ-EPL-2025-94693c	\N	Custom Requirements Analyst	\N
PROJ-EPL-2025-9c98f2	\N	Product Customization Engineer	\N
PROJ-EPL-2025-b1097b	\N	Product Customization Engineer	\N
PROJ-EPL-2025-b11250	\N	Regulatory Compliance Specialist	\N
PROJ-EPL-2025-3bf3cb	\N	Product Customization Engineer	\N
PROJ-EPL-2025-271b9d	\N	Custom Requirements Analyst	\N
PROJ-EPL-2025-6ac926	\N	Custom Requirements Analyst	\N
PROJ-EPL-2025-bc1a06	\N	Regulatory Compliance Specialist	\N
PROJ-EPL-2025-ea38f8	\N	Custom Requirements Analyst	\N
PROJ-EPL-2025-89e791	\N	Custom Requirements Analyst	\N
PROJ-EPL-2025-f5e852	\N	Custom Requirements Analyst	\N
PROJ-EPL-2025-156db9	\N	Regulatory Compliance Specialist	\N
PROJ-EPL-2025-3843ca	\N	Custom Requirements Analyst	\N
\.


--
-- Data for Name: external_project_request; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_request (ext_project_request_id, ext_project_name, ext_project_description, approval_id, item_id) FROM stdin;
PROJ-EPR-2025-c46ce6	OEC Elite x10	Manufacturing 10 units of OEC Elite C-arm X-ray machines for the client.	\N	\N
PROJ-EPR-2025-6424ba	Aquadis 56 x5	Producing 5 units of Aquadis 56 medical washer-disinfectors.	\N	\N
PROJ-EPR-2025-3e568e	UA-66 x20	Client placed an order for 20 UA-66 ultrasound machines.	\N	\N
PROJ-EPR-2025-8ab1b1	BeneVision N22/N19 x15	Hospital requires 15 BeneVision N22/N19 patient monitors.	\N	\N
PROJ-EPR-2025-14b4c2	Senographe Pristina x8	Manufacturing 8 units of Senographe Pristina mammography systems.	\N	\N
PROJ-EPR-2025-464d97	uMEC Series x12	Client ordered 12 uMEC Series patient monitors.	\N	\N
PROJ-EPR-2025-d17f4b	TNI HighFlow x25	Producing 25 TNI HighFlow respiratory therapy units.	\N	\N
PROJ-EPR-2025-6f9c73	uMed 20 x30	Manufacturing 30 units of uMed 20 portable patient monitors.	\N	\N
PROJ-EPR-2025-75beb2	Wato EX-20 x7	Client requested 7 Wato EX-20 anesthesia machines.	\N	\N
PROJ-EPR-2025-0c06ea	Rad-97 Pulse CO-Oximeter x18	Producing 18 Rad-97 Pulse CO-Oximeters for the hospital.	\N	\N
PROJ-EPR-2025-572203	OEC Elite x12	Manufacturing 12 units of OEC Elite C-arm X-ray machines for the client.	\N	\N
PROJ-EPR-2025-c423fc	Aquadis 56 x8	Producing 8 units of Aquadis 56 medical washer-disinfectors.	\N	\N
PROJ-EPR-2025-a50334	UA-66 x15	Client placed an order for 15 UA-66 ultrasound machines.	\N	\N
PROJ-EPR-2025-b36da5	BeneVision N22/N19 x20	Hospital requires 20 BeneVision N22/N19 patient monitors.	\N	\N
PROJ-EPR-2025-e95ad0	Senographe Pristina x10	Manufacturing 10 units of Senographe Pristina mammography systems.	\N	\N
PROJ-EPR-2025-cd11db	uMEC Series x18	Client ordered 18 uMEC Series patient monitors.	\N	\N
PROJ-EPR-2025-43eb50	TNI HighFlow x30	Producing 30 TNI HighFlow respiratory therapy units.	\N	\N
PROJ-EPR-2025-cfdf23	uMed 20 x35	Manufacturing 35 units of uMed 20 portable patient monitors.	\N	\N
PROJ-EPR-2025-1e039b	Wato EX-20 x9	Client requested 9 Wato EX-20 anesthesia machines.	\N	\N
PROJ-EPR-2025-d4980d	Rad-97 Pulse CO-Oximeter x22	Producing 22 Rad-97 Pulse CO-Oximeters for the hospital.	\N	\N
\.


--
-- Data for Name: external_project_task_list; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_task_list (task_id, project_id, task_description, task_status, task_deadline, project_labor_id) FROM stdin;
PROJ-EPT-2025-995b16	\N	Assemble OEC Elite frame	in_progress	2025-03-20	\N
PROJ-EPT-2025-8ed6a0	\N	Install imaging software	pending	2025-03-25	\N
PROJ-EPT-2025-7fcb6f	\N	Quality check for Aquadis 56	completed	2025-03-10	\N
PROJ-EPT-2025-6ec45c	\N	Calibrate UA-66 ultrasound sensors	in_progress	2025-03-18	\N
PROJ-EPT-2025-994271	\N	Integrate BeneVision N22/N19 with hospital systems	pending	2025-03-30	\N
PROJ-EPT-2025-208ce5	\N	Final assembly of Senographe Pristina	completed	2025-03-12	\N
PROJ-EPT-2025-fe31a3	\N	Software update for uMEC Series monitors	in_progress	2025-03-22	\N
PROJ-EPT-2025-c4918a	\N	Test airflow mechanism in TNI HighFlow devices	pending	2025-03-28	\N
PROJ-EPT-2025-553acf	\N	Assemble battery unit for uMed 20	completed	2025-03-15	\N
PROJ-EPT-2025-05095a	\N	Verify gas flow calibration for Wato EX-20	in_progress	2025-03-24	\N
PROJ-EPT-2025-fad94e	\N	Connect Rad-97 Pulse CO-Oximeter to wireless system	canceled	2025-03-26	\N
PROJ-EPT-2025-144a03	\N	Assemble components for OEC Elite units	in_progress	2025-04-15	\N
PROJ-EPT-2025-894a7b	\N	Test quality control for Aquadis 56 units	pending	2025-04-20	\N
PROJ-EPT-2025-1820e2	\N	Conduct performance calibration for UA-66	completed	2025-03-30	\N
PROJ-EPT-2025-23c05c	\N	Prepare software installation for BeneVision N22/N19	in_progress	2025-04-10	\N
PROJ-EPT-2025-5b7527	\N	Finalize packaging for Senographe Pristina units	pending	2025-04-25	\N
PROJ-EPT-2025-8f3470	\N	Perform electrical safety tests on uMEC Series	completed	2025-03-28	\N
PROJ-EPT-2025-9125a1	\N	Ensure airflow accuracy for TNI HighFlow devices	in_progress	2025-05-01	\N
PROJ-EPT-2025-99c873	\N	Update firmware on uMed 20 units	pending	2025-05-05	\N
PROJ-EPT-2025-0436a7	\N	Verify gas flow on Wato EX-20 anesthesia machines	in_progress	2025-04-12	\N
PROJ-EPT-2025-7e482f	\N	Check SpO2 sensor calibration on Rad-97 Pulse CO-Oximeter	completed	2025-06-01	\N
\.


--
-- Data for Name: external_project_tracking; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_tracking (project_tracking_id, project_id, project_milestone, start_date, estimated_end_date, project_warranty_id, project_issue) FROM stdin;
PROJ-EPTK-2025-8ca9df	\N	planning	2025-03-01	2025-03-10	\N	\N
PROJ-EPTK-2025-33580a	\N	awaiting_approval	2025-03-05	2025-03-15	\N	Pending final client confirmation
PROJ-EPTK-2025-ad1d96	\N	manufacturing	2025-03-10	2025-04-01	\N	\N
PROJ-EPTK-2025-bca243	\N	deployment	2025-03-12	2025-04-05	\N	Logistics delay in shipment
PROJ-EPTK-2025-fa0a31	\N	installation	2025-03-15	2025-04-10	\N	\N
PROJ-EPTK-2025-b63b83	\N	completed	2025-02-20	2025-03-01	\N	\N
PROJ-EPTK-2025-99746a	\N	manufacturing	2025-03-18	2025-04-12	\N	Supplier delay in component delivery
PROJ-EPTK-2025-8a5b16	\N	awaiting_approval	2025-03-22	2025-03-30	\N	\N
PROJ-EPTK-2025-e64ce1	\N	deployment	2025-03-25	2025-04-15	\N	Client requested last-minute customization
PROJ-EPTK-2025-6cbb35	\N	completed	2025-02-28	2025-03-08	\N	\N
PROJ-EPTK-2025-f06521	\N	planning	2025-03-01	2025-04-15	\N	\N
PROJ-EPTK-2025-e622b0	\N	awaiting_approval	2025-03-05	2025-04-20	\N	Pending client feedback
PROJ-EPTK-2025-52ff5d	\N	manufacturing	2025-03-10	2025-05-01	\N	\N
PROJ-EPTK-2025-4a578a	\N	deployment	2025-03-15	2025-05-10	\N	Supply chain delays
PROJ-EPTK-2025-2e6b1d	\N	installation	2025-03-20	2025-05-20	\N	\N
PROJ-EPTK-2025-92fe18	\N	completed	2025-03-25	2025-04-30	\N	\N
PROJ-EPTK-2025-8f4238	\N	planning	2025-04-01	2025-05-15	\N	Design revisions required
PROJ-EPTK-2025-c21826	\N	awaiting_approval	2025-04-05	2025-05-20	\N	\N
PROJ-EPTK-2025-f983c8	\N	manufacturing	2025-04-10	2025-06-01	\N	Material shortage
PROJ-EPTK-2025-1a8c76	\N	deployment	2025-04-15	2025-06-10	\N	\N
\.


--
-- Data for Name: external_project_warranty; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.external_project_warranty (project_warranty_id, project_id, warranty_coverage_yr, warranty_start_date, warranty_end_date) FROM stdin;
PROJ-EPW-2025-9a1e0d	\N	3	2025-04-01	2028-04-01
PROJ-EPW-2025-b63361	\N	2	2025-05-15	2027-05-15
PROJ-EPW-2025-63de60	\N	5	2025-06-10	2030-06-10
PROJ-EPW-2025-ac009b	\N	3	2025-07-20	2028-07-20
PROJ-EPW-2025-3314e7	\N	4	2025-08-05	2029-08-05
PROJ-EPW-2025-73c285	\N	2	2025-09-12	2027-09-12
PROJ-EPW-2025-2b5f68	\N	3	2025-10-18	2028-10-18
PROJ-EPW-2025-b22387	\N	1	2025-11-22	2026-11-22
PROJ-EPW-2025-fbb01c	\N	5	2025-12-30	2030-12-30
PROJ-EPW-2025-512090	\N	4	2026-01-15	2030-01-15
PROJ-EPW-2025-c9dd45	\N	2	2025-04-01	2027-04-01
PROJ-EPW-2025-16ceea	\N	3	2025-05-15	2028-05-15
PROJ-EPW-2025-917e4f	\N	1	2025-06-10	2026-06-10
PROJ-EPW-2025-fe60f3	\N	5	2025-07-20	2030-07-20
PROJ-EPW-2025-c0ef64	\N	2	2025-08-05	2027-08-05
PROJ-EPW-2025-3b3641	\N	4	2025-09-12	2029-09-12
PROJ-EPW-2025-f68c54	\N	3	2025-10-18	2028-10-18
PROJ-EPW-2025-564966	\N	2	2025-11-25	2027-11-25
PROJ-EPW-2025-8c09be	\N	1	2025-12-30	2026-12-30
PROJ-EPW-2025-67f003	\N	5	2026-01-15	2031-01-15
\.


--
-- Data for Name: internal_project_cost_management; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.internal_project_cost_management (intrnl_project_resources_id, intrnl_project_id, bom_id, project_budget_approval) FROM stdin;
PROJ-IPC-2025-6bb961	\N	\N	approved
PROJ-IPC-2025-c9a73a	\N	\N	denied
PROJ-IPC-2025-da8f48	\N	\N	approved
PROJ-IPC-2025-4929b7	\N	\N	denied
PROJ-IPC-2025-cab0e8	\N	\N	approved
PROJ-IPC-2025-c00fd5	\N	\N	approved
PROJ-IPC-2025-2c2c29	\N	\N	denied
PROJ-IPC-2025-8728f5	\N	\N	approved
PROJ-IPC-2025-5d562a	\N	\N	denied
PROJ-IPC-2025-dd80ea	\N	\N	approved
PROJ-IPC-2025-1b3dd7	\N	\N	approved
PROJ-IPC-2025-fee124	\N	\N	denied
PROJ-IPC-2025-cfcbc9	\N	\N	approved
PROJ-IPC-2025-c4bd87	\N	\N	denied
PROJ-IPC-2025-838a54	\N	\N	approved
PROJ-IPC-2025-83cbbf	\N	\N	approved
PROJ-IPC-2025-743098	\N	\N	denied
PROJ-IPC-2025-9239a5	\N	\N	approved
PROJ-IPC-2025-7cd55e	\N	\N	denied
PROJ-IPC-2025-e10d52	\N	\N	approved
\.


--
-- Data for Name: internal_project_details; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.internal_project_details (intrnl_project_id, project_request_id, intrnl_project_status, approval_id) FROM stdin;
PROJ-IPD-2025-4705c5	\N	not started	\N
PROJ-IPD-2025-2dbe61	\N	in progress	\N
PROJ-IPD-2025-c1bac3	\N	completed	\N
PROJ-IPD-2025-d2de37	\N	in progress	\N
PROJ-IPD-2025-ccdc96	\N	not started	\N
PROJ-IPD-2025-04596a	\N	completed	\N
PROJ-IPD-2025-3cc15b	\N	in progress	\N
PROJ-IPD-2025-3b277d	\N	not started	\N
PROJ-IPD-2025-212505	\N	completed	\N
PROJ-IPD-2025-32b24d	\N	in progress	\N
PROJ-IPD-2025-fa2146	\N	not started	\N
PROJ-IPD-2025-6c6a5f	\N	in progress	\N
PROJ-IPD-2025-332c95	\N	completed	\N
PROJ-IPD-2025-d13c8e	\N	in progress	\N
PROJ-IPD-2025-eafa97	\N	not started	\N
PROJ-IPD-2025-879e61	\N	completed	\N
PROJ-IPD-2025-916f2e	\N	in progress	\N
PROJ-IPD-2025-207f12	\N	not started	\N
PROJ-IPD-2025-a5ce5d	\N	completed	\N
PROJ-IPD-2025-9fab89	\N	in progress	\N
\.


--
-- Data for Name: internal_project_labor; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.internal_project_labor (intrnl_project_labor_id, intrnl_project_id, intrnl_job_role_needed, employee_id) FROM stdin;
PROJ-IPL-2025-84673e	\N	Project Manager	\N
PROJ-IPL-2025-77cc91	\N	Training Coordinator	\N
PROJ-IPL-2025-a2e143	\N	Event Coordinator	\N
PROJ-IPL-2025-8c1c30	\N	Technical Lead	\N
PROJ-IPL-2025-d259fa	\N	Department Representative	\N
PROJ-IPL-2025-7dbcb2	\N	Compliance Officer	\N
PROJ-IPL-2025-5d36d8	\N	Change Management Analyst	\N
PROJ-IPL-2025-9746dc	\N	Project Manager	\N
PROJ-IPL-2025-1ad314	\N	Project Manager	\N
PROJ-IPL-2025-ff8038	\N	Project Manager	\N
PROJ-IPL-2025-74b957	\N	Compliance Officer	\N
PROJ-IPL-2025-4696b6	\N	Change Management Analyst	\N
PROJ-IPL-2025-0b4504	\N	Compliance Officer	\N
PROJ-IPL-2025-59dfa3	\N	Change Management Analyst	\N
PROJ-IPL-2025-3efb2c	\N	Compliance Officer	\N
PROJ-IPL-2025-94217c	\N	Compliance Officer	\N
PROJ-IPL-2025-b12a53	\N	Change Management Analyst	\N
PROJ-IPL-2025-51d65c	\N	Training Coordinator	\N
PROJ-IPL-2025-1f794e	\N	Training Coordinator	\N
PROJ-IPL-2025-19476f	\N	Training Coordinator	\N
PROJ-IPL-2025-57f34d	\N	Technical Lead	\N
PROJ-IPL-2025-e72b4b	\N	Technical Lead	\N
PROJ-IPL-2025-5e30b5	\N	Technical Lead	\N
PROJ-IPL-2025-8225e4	\N	Department Representative	\N
PROJ-IPL-2025-742abe	\N	Department Representative	\N
PROJ-IPL-2025-ef3910	\N	Technical Lead	\N
PROJ-IPL-2025-b18533	\N	Event Coordinator	\N
PROJ-IPL-2025-cd0665	\N	Event Coordinator	\N
\.


--
-- Data for Name: internal_project_request; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.internal_project_request (project_request_id, project_name, project_description, request_date, target_starting_date, employee_id, dept_id, project_budget_request, project_budget_description) FROM stdin;
PROJ-IPR-2025-ec7004	ERP System Upgrade	Upgrade the ERP system with new security patches and features.	2025-03-01	2025-03-15	\N	\N	750000.00	Security patching and feature rollout
PROJ-IPR-2025-bfe3b9	Employee Training Program	Conduct training sessions for new ERP functionalities.	2025-03-05	2025-03-20	\N	\N	250000.00	Training materials, venue, and trainers
PROJ-IPR-2025-c1a963	Department Workflow Optimization	Revise department workflow for efficiency improvements.	2025-03-07	2025-03-22	\N	\N	150000.00	Process evaluation and redesign support
PROJ-IPR-2025-94c493	Cybersecurity Enhancement	Implement new security measures in the ERP system.	2025-03-10	2025-03-25	\N	\N	600000.00	Firewall upgrades and intrusion detection
PROJ-IPR-2025-333c8f	Compliance Training	Train employees on new regulatory compliance policies.	2025-03-12	2025-03-28	\N	\N	200000.00	Training sessions and compliance materials
PROJ-IPR-2025-f2d935	Inventory Management Optimization	Redesign the inventory tracking system for better performance.	2025-03-15	2025-04-01	\N	\N	400000.00	System design and implementation
PROJ-IPR-2025-59b9e6	Software Integration Plan	Integrate third-party applications with the ERP system.	2025-03-18	2025-04-05	\N	\N	500000.00	Integration tools and testing resources
PROJ-IPR-2025-dcac23	Leadership Training	Conduct leadership workshops for department managers.	2025-03-20	2025-04-10	\N	\N	300000.00	Facilitators and leadership content
PROJ-IPR-2025-2fe02b	HR Policy Review	Analyze and update HR policies in accordance with new labor laws.	2025-03-22	2025-04-08	\N	\N	125000.00	Legal consultation and policy updates
PROJ-IPR-2025-a95c74	IT Infrastructure Upgrade	Upgrade servers and network infrastructure for better performance.	2025-03-25	2025-04-12	\N	\N	1000000.00	Server hardware and network expansion
PROJ-IPR-2025-2a3ffb	ERP System Upgrade	Upgrade the ERP system to improve performance and security.	2025-03-01	2025-03-15	\N	\N	750000.00	General performance upgrade
PROJ-IPR-2025-d72eac	New Compliance Training	Conduct training sessions for new regulatory compliance.	2025-03-05	2025-03-20	\N	\N	200000.00	Regulatory updates and training
PROJ-IPR-2025-3287a6	Inventory Management Overhaul	Redesign inventory tracking processes.	2025-03-10	2025-03-25	\N	\N	475000.00	Overhaul and process reengineering
PROJ-IPR-2025-64bfca	Cybersecurity Enhancement	Implement additional security protocols.	2025-03-12	2025-03-30	\N	\N	700000.00	Advanced protocols and monitoring
PROJ-IPR-2025-a0722f	Employee Onboarding Program	Develop a structured onboarding process.	2025-03-15	2025-04-01	\N	\N	175000.00	Onboarding materials and portal setup
PROJ-IPR-2025-b3688b	New Module Development	Add a new project tracking module.	2025-03-18	2025-04-05	\N	\N	550000.00	Module development and deployment
PROJ-IPR-2025-11f7a5	Medical Equipment Maintenance Plan	Create a preventive maintenance schedule.	2025-03-20	2025-04-10	\N	\N	250000.00	Scheduling tools and reporting
PROJ-IPR-2025-63545d	Customer Support Training	Enhance training for customer support staff.	2025-03-22	2025-04-12	\N	\N	225000.00	Customer handling and ticketing systems
PROJ-IPR-2025-c3f778	Data Migration Strategy	Plan for migrating legacy data to the new system.	2025-03-25	2025-04-15	\N	\N	350000.00	Data mapping and test runs
PROJ-IPR-2025-0a2fee	Compliance Audit Preparation	Prepare for an external compliance audit.	2025-03-28	2025-04-20	\N	\N	300000.00	Audit consultants and documentation
\.


--
-- Data for Name: internal_project_task_list; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.internal_project_task_list (intrnl_task_id, intrnl_project_id, intrnl_task_description, intrnl_task_status, intrnl_task_deadline, intrnl_project_labor_id) FROM stdin;
PROJ-IPT-2025-d6fcd6	\N	Gather requirements for ERP upgrade	in_progress	2025-04-15	\N
PROJ-IPT-2025-115d0b	\N	Review security patches	pending	2025-04-20	\N
PROJ-IPT-2025-626845	\N	Schedule training sessions	in_progress	2025-04-10	\N
PROJ-IPT-2025-750047	\N	Prepare training materials	completed	2025-03-30	\N
PROJ-IPT-2025-854f72	\N	Analyze current workflow	completed	2025-03-15	\N
PROJ-IPT-2025-530b69	\N	Develop cybersecurity guidelines	in_progress	2025-04-25	\N
PROJ-IPT-2025-bfd8f8	\N	Implement firewall upgrades	pending	2025-05-10	\N
PROJ-IPT-2025-2281db	\N	Prepare compliance training module	completed	2025-03-28	\N
PROJ-IPT-2025-ab4bc0	\N	Revise inventory tracking system	pending	2025-05-01	\N
PROJ-IPT-2025-52821d	\N	Evaluate third-party integrations	in_progress	2025-05-05	\N
PROJ-IPT-2025-ce66ea	\N	Organize leadership workshops	completed	2025-04-08	\N
PROJ-IPT-2025-5c6b70	\N	Update HR policies	pending	2025-04-12	\N
PROJ-IPT-2025-75cc1f	\N	Upgrade IT infrastructure	in_progress	2025-06-01	\N
PROJ-IPT-2025-d7dd52	\N	Gather requirements from department heads.	pending	2025-04-10	\N
PROJ-IPT-2025-70637e	\N	Develop training materials for new ERP users.	in_progress	2025-04-15	\N
PROJ-IPT-2025-c06bd6	\N	Conduct initial cybersecurity risk assessment.	pending	2025-04-20	\N
PROJ-IPT-2025-f3061b	\N	Review current inventory tracking methods.	in_progress	2025-04-25	\N
PROJ-IPT-2025-14dd24	\N	Perform software testing on the upgraded module.	pending	2025-05-01	\N
PROJ-IPT-2025-504e13	\N	Create compliance checklist for upcoming audit.	completed	2025-05-05	\N
PROJ-IPT-2025-7c7a07	\N	Schedule system migration meeting with IT team.	canceled	2025-05-10	\N
PROJ-IPT-2025-f48e16	\N	Finalize new employee onboarding process.	in_progress	2025-05-15	\N
PROJ-IPT-2025-35af86	\N	Develop data backup strategy before migration.	pending	2025-05-20	\N
PROJ-IPT-2025-0bbb73	\N	Implement new customer support workflow.	completed	2025-05-25	\N
\.


--
-- Data for Name: internal_project_tracking; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.internal_project_tracking (intrnl_project_tracking_id, intrnl_project_id, intrnl_start_date, intrnl_estimated_end_date, intrnl_project_issue) FROM stdin;
PROJ-IPT-2025-1992fe	\N	2025-04-01	2025-06-01	\N
PROJ-IPT-2025-2aa999	\N	2025-03-15	2025-05-20	Delayed due to scheduling conflicts
PROJ-IPT-2025-b8f90f	\N	2025-02-10	2025-03-30	\N
PROJ-IPT-2025-39e9c2	\N	2025-03-20	2025-06-15	Technical issue with implementation
PROJ-IPT-2025-5cdb7f	\N	2025-04-05	2025-06-10	\N
PROJ-IPT-2025-1bdbf6	\N	2025-01-25	2025-03-01	\N
PROJ-IPT-2025-661e42	\N	2025-03-18	2025-05-12	Resource allocation issue
PROJ-IPT-2025-84d2f5	\N	2025-04-10	2025-07-01	\N
PROJ-IPT-2025-3d2ac8	\N	2025-02-28	2025-04-15	Revisions needed in project scope
PROJ-IPT-2025-132adb	\N	2025-03-25	2025-06-05	\N
PROJ-IPT-2025-30ce5b	\N	2025-04-01	2025-05-15	\N
PROJ-IPT-2025-33855e	\N	2025-04-05	2025-06-01	Resource allocation conflict
PROJ-IPT-2025-98e9c6	\N	2025-04-10	2025-05-25	\N
PROJ-IPT-2025-74826e	\N	2025-04-15	2025-06-10	Delay in software implementation
PROJ-IPT-2025-7794f9	\N	2025-04-20	2025-06-15	\N
PROJ-IPT-2025-4cb89a	\N	2025-04-25	2025-06-20	Pending final approval
PROJ-IPT-2025-313d62	\N	2025-05-01	2025-06-30	\N
PROJ-IPT-2025-2c2a4e	\N	2025-05-05	2025-07-10	System testing required additional time
PROJ-IPT-2025-f5b68b	\N	2025-05-10	2025-07-15	\N
PROJ-IPT-2025-b7941b	\N	2025-05-15	2025-07-20	Unexpected technical challenges
\.


--
-- Data for Name: report_monitoring; Type: TABLE DATA; Schema: project_management; Owner: postgres
--

COPY project_management.report_monitoring (report_monitoring_id, project_id, intrnl_project_id, report_type, report_title, received_from, date_created, assigned_to, description) FROM stdin;
PROJ-RPM-2025-6b33be	\N	\N	Sales Order	Quarterly Sales Performance	Sales	2025-03-01	Management	Analysis of quarterly sales trends.
PROJ-RPM-2025-b584ca	\N	\N	Resource Availability	HR Resource Utilization	Human Resources	2025-03-02	Operations	Report on current staff allocation.
PROJ-RPM-2025-85b817	\N	\N	Bill of Material	Component Breakdown for Model X	Production	2025-03-03	Inventory	Detailed BoM for upcoming production.
PROJ-RPM-2025-385f1c	\N	\N	Information	ERP User Guide Update	Admin	2025-03-04	Solution Customizing	Revision of user guide for latest ERP version.
PROJ-RPM-2025-c11edf	\N	\N	Progress Report	Project Alpha Status	Project Management	2025-03-05	Management	Current project progress and blockers.
PROJ-RPM-2025-65e383	\N	\N	Project Details	Warehouse Expansion Plan	Operations	2025-03-06	Finance	Financial projection for expansion.
PROJ-RPM-2025-239f29	\N	\N	Sales Order	Regional Sales Analysis	Sales	2025-03-07	Accounting	Comparison of sales performance across regions.
PROJ-RPM-2025-4cf755	\N	\N	Resource Availability	Machine Availability in Plant A	MRP	2025-03-08	Production	List of operational and under-maintenance machines.
PROJ-RPM-2025-13c994	\N	\N	Bill of Material	BoM for Custom Order 2345	Purchasing	2025-03-09	Inventory	Itemized bill for a specific order.
PROJ-RPM-2025-2837bc	\N	\N	Information	Tax Compliance Updates	Finance	2025-03-10	Accounting	Latest tax regulations affecting the company.
PROJ-RPM-2025-51deb2	\N	\N	Progress Report	IT Infrastructure Upgrade	Admin	2025-03-11	Management	Status of ongoing IT infrastructure enhancements.
PROJ-RPM-2025-ed5a30	\N	\N	Project Details	New Product Development Timeline	Project Management	2025-03-12	Operations	Projected milestones for product launch.
PROJ-RPM-2025-5722da	\N	\N	Sales Order	Major Client Orders Overview	Sales	2025-03-13	Distribution	List of key clients and their orders.
PROJ-RPM-2025-336192	\N	\N	Resource Availability	On-Site Workforce Report	Human Resources	2025-03-14	Operations	Summary of available staff per site.
PROJ-RPM-2025-99d8b2	\N	\N	Bill of Material	Raw Material Requirements	Inventory	2025-03-15	Purchasing	Monthly forecast for required materials.
PROJ-RPM-2025-8c58d9	\N	\N	Information	ERP System Security Report	Solution Customizing	2025-03-16	Admin	Review of security measures in place.
PROJ-RPM-2025-89c141	\N	\N	Progress Report	Marketing Campaign Results	Management	2025-03-17	Sales	Performance of recent marketing initiatives.
PROJ-RPM-2025-864b4e	\N	\N	Project Details	Supply Chain Optimization Plan	Distribution	2025-03-18	Finance	Cost-benefit analysis of supply chain improvements.
PROJ-RPM-2025-36b090	\N	\N	Sales Order	E-commerce Sales Trends	Sales	2025-03-19	Management	Online sales performance breakdown.
PROJ-RPM-2025-fe60ed	\N	\N	Resource Availability	Fleet Utilization Report	Operations	2025-03-20	Distribution	Usage analysis of company logistics vehicles.
\.


--
-- Data for Name: batch_inspection; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.batch_inspection (inspection_id, shipment_id, employee_id, inspection_date, inspection_result, remarks) FROM stdin;
PURCHASING-BAI-2025-3f145f	\N	\N	2025-04-19	Pass	All items in good condition
PURCHASING-BAI-2025-6ff4a2	\N	\N	2025-04-23	Pass	Minor packaging damage, contents intact
PURCHASING-BAI-2025-e14d82	\N	\N	2025-04-28	Fail	Quality below specification
PURCHASING-BAI-2025-9b3fdc	\N	\N	2025-05-03	Pass	Complete and as ordered
PURCHASING-BAI-2025-2f17c3	\N	\N	2025-05-08	Pass	Passed all quality checks
PURCHASING-BAI-2025-482ec8	\N	\N	2025-05-13	Fail	15% of shipment damaged during transit
PURCHASING-BAI-2025-5234ac	\N	\N	2025-05-18	Pass	All items verified against order
PURCHASING-BAI-2025-ffe6bf	\N	\N	2025-05-23	Pass	Quantity and quality verified
PURCHASING-BAI-2025-ff88eb	\N	\N	2025-05-28	Fail	Wrong specifications delivered
PURCHASING-BAI-2025-e2e2a0	\N	\N	2025-06-02	Pass	Complete and in perfect condition
\.


--
-- Data for Name: credit_memo; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.credit_memo (credit_memo_id, invoice_id, inspection_id, status, document_no, document_date, delivery_date, due_date, total_credit, credit_balance, dpm_rate, dpm_amount, applied_amount, balance_due) FROM stdin;
PURCHASING-CRM-2025-caa83f	\N	\N	Pending	80001	2025-04-20	2025-04-19	2025-05-20	1000.00	1000.00	0.00	0.00	0.00	1000.00
PURCHASING-CRM-2025-97bd38	\N	\N	Approved	80002	2025-04-24	2025-04-23	2025-05-24	500.00	500.00	0.00	0.00	0.00	500.00
PURCHASING-CRM-2025-158c10	\N	\N	Completed	80003	2025-04-29	2025-04-28	2025-05-29	3000.00	0.00	0.00	0.00	3000.00	0.00
PURCHASING-CRM-2025-f1b8d5	\N	\N	Rejected	80004	2025-05-04	2025-05-03	2025-06-04	250.00	250.00	0.00	0.00	0.00	250.00
PURCHASING-CRM-2025-3dd049	\N	\N	Pending	80005	2025-05-09	2025-05-08	2025-06-09	750.00	750.00	0.00	0.00	0.00	750.00
PURCHASING-CRM-2025-69e58b	\N	\N	Approved	80006	2025-05-14	2025-05-13	2025-06-14	2500.00	2500.00	0.00	0.00	0.00	2500.00
PURCHASING-CRM-2025-112b73	\N	\N	Completed	80007	2025-05-19	2025-05-18	2025-06-19	150.00	0.00	0.00	0.00	150.00	0.00
PURCHASING-CRM-2025-f39f42	\N	\N	Pending	80008	2025-05-24	2025-05-23	2025-06-24	350.00	350.00	0.00	0.00	0.00	350.00
PURCHASING-CRM-2025-df326a	\N	\N	Approved	80009	2025-05-29	2025-05-28	2025-06-29	1800.00	1800.00	0.00	0.00	0.00	1800.00
PURCHASING-CRM-2025-2e4d3f	\N	\N	Completed	80010	2025-06-03	2025-06-02	2025-07-03	200.00	0.00	0.00	0.00	200.00	0.00
\.


--
-- Data for Name: purchase_invoice; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_invoice (invoice_id, content_id, status, document_no, document_date, due_date, total_credit, credit_balance, dpm_rate, dpm_amount, applied_amount, balance_due) FROM stdin;
PURCHASING-PUI-2025-e90ec0	\N	Pending	90001	2025-04-05	2025-05-05	5000.00	5000.00	2.00	100.00	0.00	4900.00
PURCHASING-PUI-2025-1a2acf	\N	Approved	90002	2025-04-10	2025-05-10	7500.00	7500.00	3.00	225.00	0.00	7275.00
PURCHASING-PUI-2025-2ded56	\N	Completed	90003	2025-04-15	2025-05-15	3000.00	3000.00	1.50	45.00	2955.00	0.00
PURCHASING-PUI-2025-811c21	\N	Approved	90004	2025-04-20	2025-05-20	8000.00	8000.00	2.50	200.00	4000.00	3800.00
PURCHASING-PUI-2025-c5c471	\N	Pending	90005	2025-04-25	2025-05-25	9500.00	9500.00	3.50	332.50	0.00	9167.50
PURCHASING-PUI-2025-011d8b	\N	Completed	90006	2025-04-30	2025-05-30	2500.00	2500.00	2.00	50.00	2450.00	0.00
PURCHASING-PUI-2025-d95428	\N	Rejected	90007	2025-05-05	2025-06-05	1500.00	1500.00	1.00	15.00	0.00	1485.00
PURCHASING-PUI-2025-08fabf	\N	Pending	90008	2025-05-10	2025-06-10	12000.00	12000.00	4.00	480.00	0.00	11520.00
PURCHASING-PUI-2025-ca26c1	\N	Approved	90009	2025-05-15	2025-06-15	6000.00	6000.00	2.50	150.00	3000.00	2850.00
PURCHASING-PUI-2025-cef0f7	\N	Completed	90010	2025-05-20	2025-06-20	4500.00	4500.00	3.00	135.00	4365.00	0.00
\.


--
-- Data for Name: purchase_order; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_order (purchase_id, quotation_id, order_date, delivery_date, document_date, status) FROM stdin;
PURCHASING-PUO-2025-4dd723	\N	2025-04-01	2025-04-15	2025-03-25	Pending
PURCHASING-PUO-2025-8b54be	\N	2025-04-05	2025-04-20	2025-03-30	Approved
PURCHASING-PUO-2025-7c80ac	\N	2025-04-10	2025-04-25	2025-04-05	Completed
PURCHASING-PUO-2025-0a3533	\N	2025-04-15	2025-04-30	2025-04-10	Pending
PURCHASING-PUO-2025-1650c3	\N	2025-04-20	2025-05-05	2025-04-15	Approved
PURCHASING-PUO-2025-c6bd7f	\N	2025-04-25	2025-05-10	2025-04-20	Rejected
PURCHASING-PUO-2025-a5a52e	\N	2025-04-30	2025-05-15	2025-04-25	Pending
PURCHASING-PUO-2025-fdfa90	\N	2025-05-05	2025-05-20	2025-04-30	Approved
PURCHASING-PUO-2025-cd088b	\N	2025-05-10	2025-05-25	2025-05-05	Completed
PURCHASING-PUO-2025-f92747	\N	2025-05-15	2025-05-30	2025-05-10	Pending
\.


--
-- Data for Name: purchase_quotation; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_quotation (quotation_id, request_id, vendor_code, status, document_no, valid_date, document_date, required_date, remarks, delivery_loc, downpayment_request, total_before_discount, discount_percent, freight, tax, total_payment) FROM stdin;
PURCHASING-PUQ-2025-4801c0	\N	\N	Pending	10001	2025-04-15	2025-03-20	2025-04-30	Standard order for Q2	Warehouse A	0	5000.00	10.00	250.00	500.00	4750.00
PURCHASING-PUQ-2025-b314bf	\N	\N	Approved	10002	2025-04-20	2025-03-22	2025-05-05	Urgent order for production	Factory B	20	7500.00	5.00	300.00	750.00	7175.00
PURCHASING-PUQ-2025-0195d7	\N	\N	Rejected	10003	2025-04-25	2025-03-25	2025-05-10	Over budget requirements	Warehouse C	0	3000.00	2.00	150.00	300.00	2940.00
PURCHASING-PUQ-2025-0344c3	\N	\N	Pending	10004	2025-05-01	2025-03-28	2025-05-15	Seasonal stock replenishment	Distribution Center D	10	8000.00	15.00	400.00	800.00	7180.00
PURCHASING-PUQ-2025-d178bf	\N	\N	Approved	10005	2025-05-05	2025-04-01	2025-05-20	New product line materials	Factory A	30	9500.00	7.50	475.00	950.00	9253.75
PURCHASING-PUQ-2025-715a0c	\N	\N	Completed	10006	2025-05-10	2025-04-05	2025-05-25	Maintenance supplies	Maintenance Dept E	0	2500.00	2.50	125.00	250.00	2812.50
PURCHASING-PUQ-2025-43ed3d	\N	\N	Pending	10007	2025-05-15	2025-04-08	2025-05-30	Office supplies	Admin Building F	0	1500.00	5.00	75.00	150.00	1650.00
PURCHASING-PUQ-2025-47040f	\N	\N	Approved	10008	2025-05-20	2025-04-12	2025-06-05	IT equipment refresh	IT Department G	50	12000.00	10.00	600.00	1200.00	11400.00
PURCHASING-PUQ-2025-caa4d5	\N	\N	Rejected	10009	2025-05-25	2025-04-15	2025-06-10	Non-approved vendor	R&D Lab H	0	6000.00	0.00	300.00	600.00	6900.00
PURCHASING-PUQ-2025-a581eb	\N	\N	Completed	10010	2025-05-30	2025-04-18	2025-06-15	Safety equipment	Safety Dept I	25	4500.00	12.50	225.00	450.00	4106.25
\.


--
-- Data for Name: purchase_requests; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.purchase_requests (request_id, employee_id, approval_id, valid_date, document_date, required_date) FROM stdin;
PURCHASING-PUR-2025-3c0dac	\N	\N	2025-03-15	2025-03-10	2025-03-30
PURCHASING-PUR-2025-5b2fe5	\N	\N	2025-03-20	2025-03-12	2025-04-05
PURCHASING-PUR-2025-997def	\N	\N	2025-03-25	2025-03-15	2025-04-10
PURCHASING-PUR-2025-8ca289	\N	\N	2025-03-30	2025-03-18	2025-04-15
PURCHASING-PUR-2025-14d459	\N	\N	2025-04-05	2025-03-20	2025-04-20
PURCHASING-PUR-2025-a14428	\N	\N	2025-04-10	2025-03-25	2025-04-25
PURCHASING-PUR-2025-389469	\N	\N	2025-04-15	2025-03-28	2025-04-30
PURCHASING-PUR-2025-c3d941	\N	\N	2025-04-20	2025-04-01	2025-05-05
PURCHASING-PUR-2025-3ab8bc	\N	\N	2025-04-25	2025-04-05	2025-05-10
PURCHASING-PUR-2025-7c156c	\N	\N	2025-04-30	2025-04-10	2025-05-15
\.


--
-- Data for Name: quotation_contents; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.quotation_contents (quotation_content_id, request_id, material_id, asset_id, purchase_quantity, unit_price, discount, tax_code, total) FROM stdin;
PURCHASING-QUC-2025-ffa371	\N	\N	\N	100	25.50	2.50	TX001	2500.00
PURCHASING-QUC-2025-741c7e	\N	\N	\N	50	100.00	10.00	TX002	4500.00
PURCHASING-QUC-2025-7fc1bd	\N	\N	\N	200	5.75	0.75	TX001	1000.00
PURCHASING-QUC-2025-e9a362	\N	\N	\N	75	30.25	3.00	TX003	2043.75
PURCHASING-QUC-2025-093d05	\N	\N	\N	150	12.99	1.29	TX002	1750.65
PURCHASING-QUC-2025-ba74e3	\N	\N	\N	300	2.50	0.25	TX001	675.00
PURCHASING-QUC-2025-4411d3	\N	\N	\N	25	199.99	20.00	TX003	4499.75
PURCHASING-QUC-2025-d02c3e	\N	\N	\N	500	1.20	0.10	TX002	550.00
PURCHASING-QUC-2025-820d5b	\N	\N	\N	40	79.50	7.95	TX001	2860.20
PURCHASING-QUC-2025-7f68d5	\N	\N	\N	120	15.75	1.50	TX003	1710.00
\.


--
-- Data for Name: received_shipments; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.received_shipments (shipment_id, purchase_id, delivery_date) FROM stdin;
PURCHASING-RES-2025-881d8a	\N	2025-04-18
PURCHASING-RES-2025-212a00	\N	2025-04-22
PURCHASING-RES-2025-23729e	\N	2025-04-27
PURCHASING-RES-2025-205a9e	\N	2025-05-02
PURCHASING-RES-2025-07b0ba	\N	2025-05-07
PURCHASING-RES-2025-f38926	\N	2025-05-12
PURCHASING-RES-2025-2ce2f7	\N	2025-05-17
PURCHASING-RES-2025-8271ab	\N	2025-05-22
PURCHASING-RES-2025-db44ce	\N	2025-05-27
PURCHASING-RES-2025-66bfbb	\N	2025-06-01
\.


--
-- Data for Name: vendor_application; Type: TABLE DATA; Schema: purchasing; Owner: postgres
--

COPY purchasing.vendor_application (application_reference, status, company_name, tax_number, contact_person, title, vendor_address, phone, fax, vendor_email, tax_exempt, vendor_website, organization_type, separate_checks, purchasing_card, account_no, routing_no, requestor, date_requested) FROM stdin;
PURCHASING-VEP-2025-95047a	Pending	Acme Supplies	123456789	John Doe	Procurement Manager	123 Main St, Anytown, USA	5551234567	5551234568	john@acmesupplies.com	t	www.acmesupplies.com	Corporation	f	t	987654321	12345	Sarah Smith	2025-01-15
PURCHASING-VEP-2025-90da27	Approved	Beta Materials	234567890	Jane Smith	CEO	456 Oak St, Othertown, USA	5552345678	5552345679	jane@betamaterials.com	f	www.betamaterials.com	LLC	t	t	876543210	23456	Mike Johnson	2025-01-20
PURCHASING-VEP-2025-4e05ee	Rejected	Gamma Industries	345678901	Bob Brown	Sales Director	789 Pine St, Somewhere, USA	5553456789	5553456780	bob@gammaindustries.com	t	www.gammaindustries.com	Partnership	f	f	765432109	34567	Lisa Davis	2025-01-25
PURCHASING-VEP-2025-5ce8bd	Pending	Delta Manufacturing	456789012	Alice Green	Operations Manager	101 Elm St, Nowhere, USA	5554567890	5554567891	alice@deltamfg.com	f	www.deltamfg.com	Corporation	t	f	654321098	45678	Tom Wilson	2025-02-01
PURCHASING-VEP-2025-a9bf9e	Approved	Epsilon Tools	567890123	Charlie White	Owner	202 Cedar St, Anywhere, USA	5555678901	5555678902	charlie@epsilontools.com	t	www.epsilontools.com	Sole Proprietorship	f	t	543210987	56789	Emma Miller	2025-02-05
PURCHASING-VEP-2025-574d5c	Pending	Zeta Electronics	678901234	Diana Black	Purchasing Agent	303 Birch St, Everywhere, USA	5556789012	5556789013	diana@zetaelectronics.com	f	www.zetaelectronics.com	Corporation	t	t	432109876	67890	James Moore	2025-02-10
PURCHASING-VEP-2025-9cc6f5	Approved	Eta Chemicals	789012345	Edward Gray	Finance Director	404 Maple St, Elsewhere, USA	5557890123	5557890124	edward@etachemicals.com	t	www.etachemicals.com	LLC	f	f	321098765	78901	Olivia Taylor	2025-02-15
PURCHASING-VEP-2025-e7eb14	Rejected	Theta Plastics	890123456	Fiona Red	General Manager	505 Spruce St, Someplace, USA	5558901234	5558901235	fiona@thetaplastics.com	f	www.thetaplastics.com	Corporation	t	f	210987654	89012	Daniel Anderson	2025-02-20
PURCHASING-VEP-2025-0a07ae	Pending	Iota Metals	901234567	George Yellow	President	606 Walnut St, Otherplace, USA	5559012345	5559012346	george@iotametals.com	t	www.iotametals.com	Partnership	f	t	109876543	90123	Sophia Thomas	2025-02-25
PURCHASING-VEP-2025-bd4e10	Approved	Kappa Textiles	123123123	Helen Blue	Supply Chain Manager	707 Ash St, Thisplace, USA	5551231231	5551231232	helen@kappatextiles.com	f	www.kappatextiles.com	Corporation	t	t	876123456	12312	Ethan Jackson	2025-03-01
\.


--
-- Data for Name: blanket_agreement; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.blanket_agreement (agreement_id, statement_id, start_date, end_date, description, signed_date, agreement_method) FROM stdin;
SALES-AGRMNT-2025-10d6dc	\N	2025-01-01 00:00:00	2026-01-01 00:00:00	Hospital Equipment Supply	2025-01-02 00:00:00	Written
SALES-AGRMNT-2025-cd0aef	\N	2025-02-01 00:00:00	2026-02-01 00:00:00	Medical Device Agreement	2025-02-02 00:00:00	Electronic
SALES-AGRMNT-2025-881c53	\N	2025-03-01 00:00:00	2026-03-01 00:00:00	Diagnostic Equipment Supply	2025-03-02 00:00:00	Oral
SALES-AGRMNT-2025-2ed6dc	\N	2025-04-01 00:00:00	2026-04-01 00:00:00	Pharmaceutical Supplies Contract	2025-04-02 00:00:00	Written
SALES-AGRMNT-2025-3ec962	\N	2025-05-01 00:00:00	2026-05-01 00:00:00	Medical Accessories Supply	2025-05-02 00:00:00	Electronic
SALES-AGRMNT-2025-c50b6b	\N	2025-06-01 00:00:00	2026-06-01 00:00:00	Lab Equipment Agreement	2025-06-02 00:00:00	Written
SALES-AGRMNT-2025-3a0109	\N	2025-07-01 00:00:00	2026-07-01 00:00:00	Hospital Beds & Furniture	2025-07-02 00:00:00	Electronic
SALES-AGRMNT-2025-b3fbbd	\N	2025-08-01 00:00:00	2026-08-01 00:00:00	Pharmaceutical Distribution	2025-08-02 00:00:00	Oral
SALES-AGRMNT-2025-fc3fd8	\N	2025-09-01 00:00:00	2026-09-01 00:00:00	Surgical Equipment Agreement	2025-09-02 00:00:00	Written
SALES-AGRMNT-2025-cd2397	\N	2025-10-01 00:00:00	2026-10-01 00:00:00	Pediatric Medical Supplies	2025-10-02 00:00:00	Electronic
SALES-AGRMNT-2025-e13ad9	\N	2025-11-01 00:00:00	2026-11-01 00:00:00	Radiology Equipment Supply	2025-11-02 00:00:00	Written
SALES-AGRMNT-2025-fa0f75	\N	2025-12-01 00:00:00	2026-12-01 00:00:00	Dental Supplies Contract	2025-12-02 00:00:00	Electronic
SALES-AGRMNT-2025-e768fa	\N	2026-01-01 00:00:00	2027-01-01 00:00:00	Emergency Medical Kits	2026-01-02 00:00:00	Oral
SALES-AGRMNT-2025-bc856b	\N	2026-02-01 00:00:00	2027-02-01 00:00:00	Orthopedic Implants Agreement	2026-02-02 00:00:00	Written
SALES-AGRMNT-2025-567cd2	\N	2026-03-01 00:00:00	2027-03-01 00:00:00	Anesthesia Equipment Supply	2026-03-02 00:00:00	Electronic
SALES-AGRMNT-2025-dfeeca	\N	2026-04-01 00:00:00	2027-04-01 00:00:00	Medical Imaging Supplies	2026-04-02 00:00:00	Written
SALES-AGRMNT-2025-691a88	\N	2026-05-01 00:00:00	2027-05-01 00:00:00	Hospital IT Infrastructure	2026-05-02 00:00:00	Electronic
SALES-AGRMNT-2025-c552bc	\N	2026-06-01 00:00:00	2027-06-01 00:00:00	Pharmacy Automation Systems	2026-06-02 00:00:00	Oral
SALES-AGRMNT-2025-cf88ad	\N	2026-07-01 00:00:00	2027-07-01 00:00:00	Rehabilitation Equipment	2026-07-02 00:00:00	Written
SALES-AGRMNT-2025-78562d	\N	2026-08-01 00:00:00	2027-08-01 00:00:00	Veterinary Medical Supplies	2026-08-02 00:00:00	Electronic
\.


--
-- Data for Name: campaign_contacts; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.campaign_contacts (contact_id, customer_id, campaign_id, response_status) FROM stdin;
SALES-CONTACT-2025-81e34e	\N	\N	Interested
SALES-CONTACT-2025-ccd511	\N	\N	Not Interested
SALES-CONTACT-2025-ac930e	\N	\N	Pending
SALES-CONTACT-2025-237881	\N	\N	Interested
SALES-CONTACT-2025-6e894b	\N	\N	Not Interested
SALES-CONTACT-2025-baa091	\N	\N	Interested
SALES-CONTACT-2025-61d7cc	\N	\N	Pending
SALES-CONTACT-2025-1bc7f5	\N	\N	Not Interested
SALES-CONTACT-2025-df0ec8	\N	\N	Interested
SALES-CONTACT-2025-eaeea1	\N	\N	Pending
SALES-CONTACT-2025-cca14f	\N	\N	Interested
SALES-CONTACT-2025-b1f898	\N	\N	Not Interested
SALES-CONTACT-2025-16bfad	\N	\N	Pending
SALES-CONTACT-2025-80d170	\N	\N	Interested
SALES-CONTACT-2025-1c0483	\N	\N	Not Interested
SALES-CONTACT-2025-76580c	\N	\N	Interested
SALES-CONTACT-2025-747d63	\N	\N	Pending
SALES-CONTACT-2025-3dc69c	\N	\N	Not Interested
SALES-CONTACT-2025-a32577	\N	\N	Interested
SALES-CONTACT-2025-e0bed1	\N	\N	Pending
\.


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.campaigns (campaign_id, campaign_name, type, start_date, end_date) FROM stdin;
SALES-CMPGN-2025-ffa1a3	New Medical Equipment Launch	Email	2025-04-01 08:00:00	2025-04-15 23:59:59
SALES-CMPGN-2025-a5b9ae	Exclusive Discount for Clinics	Email	2025-03-20 08:00:00	2025-04-05 23:59:59
SALES-CMPGN-2025-469052	Hospital Procurement Webinar	Email	2025-03-10 08:00:00	2025-03-15 23:59:59
SALES-CMPGN-2025-ecca34	Free Sample: Surgical Masks	Email	2025-04-10 08:00:00	2025-04-20 23:59:59
SALES-CMPGN-2025-2faf77	Loyalty Rewards for Pharmacies	Email	2025-03-01 08:00:00	2025-03-31 23:59:59
SALES-CMPGN-2025-c98d48	Medical Device Compliance Update	Email	2025-02-20 08:00:00	2025-03-05 23:59:59
SALES-CMPGN-2025-7287ae	Healthcare Expo Invitation	Email	2025-04-05 08:00:00	2025-04-25 23:59:59
SALES-CMPGN-2025-2e53d6	Exclusive Bulk Order Offer	Email	2025-03-15 08:00:00	2025-03-30 23:59:59
SALES-CMPGN-2025-17f15d	New FDA-Approved Products	Email	2025-02-10 08:00:00	2025-02-28 23:59:59
SALES-CMPGN-2025-137224	Emergency Medical Supplies Sale	Email	2025-04-12 08:00:00	2025-04-22 23:59:59
SALES-CMPGN-2025-2c067f	Medical Equipment Expo 2025	Email	2025-05-01 08:00:00	2025-05-15 23:59:59
SALES-CMPGN-2025-7fb45d	Pharmacy Discount Campaign	Email	2025-04-10 08:00:00	2025-04-25 23:59:59
SALES-CMPGN-2025-8d81f5	Healthcare Innovation Webinar	Email	2025-03-25 08:00:00	2025-04-05 23:59:59
SALES-CMPGN-2025-7f8504	Free Sample: Diagnostic Kits	Email	2025-05-05 08:00:00	2025-05-20 23:59:59
SALES-CMPGN-2025-468475	Loyalty Program for Hospitals	Email	2025-04-01 08:00:00	2025-04-30 23:59:59
SALES-CMPGN-2025-07e4b0	Medical Compliance Training	Email	2025-03-15 08:00:00	2025-03-25 23:59:59
SALES-CMPGN-2025-23b237	Healthcare Summit Invitation	Email	2025-05-10 08:00:00	2025-05-30 23:59:59
SALES-CMPGN-2025-8f1e42	Exclusive Offer: Lab Equipment	Email	2025-04-15 08:00:00	2025-04-30 23:59:59
SALES-CMPGN-2025-14ff34	New Product Launch: Ventilators	Email	2025-03-20 08:00:00	2025-04-10 23:59:59
SALES-CMPGN-2025-04f648	Emergency Supplies Discount	Email	2025-05-12 08:00:00	2025-05-25 23:59:59
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.customers (customer_id, gl_account_id, partner_id, name, contact_person, email_address, phone_number, address_line1, address_line2, city, postal_code, country, customer_type, status, debt) FROM stdin;
SALES-CUST-2025-11c3dc	ACC-GLA-2025-46da91	ADMIN-PARTNER-2025-d56504	St. Luke's Medical Center	Dr. Maria Santos	contact@stlukes.com.ph	+63-2-8723-0101	279 E. Rodriguez Sr. Avenue	Quezon City	Quezon City	1112	Philippines	Client	Active	1500.00
SALES-CUST-2025-581de7	ACC-GLA-2025-ec62c8	ADMIN-PARTNER-2025-4d55e0	Makati Medical Center	Mr. Juan Dela Cruz	info@makatimed.com.ph	+63-2-8888-9999	2 Amorsolo Street	Legaspi Village	Makati	1229	Philippines	Client	Active	2500.00
SALES-CUST-2025-ee8185	ACC-GLA-2025-5fe592	ADMIN-PARTNER-2025-d121cb	The Medical City	Dr. Robert Lim	support@medicalcity.com.ph	+63-2-8639-2000	Ortigas Avenue	Pasig City	Pasig	1605	Philippines	Client	Active	0.00
SALES-CUST-2025-a06fff	ACC-GLA-2025-0f86be	ADMIN-PARTNER-2025-6e61fa	Asian Hospital and Medical Center	Ms. Anna Reyes	sales@asianhospital.com.ph	+63-2-8771-9000	2205 Civic Drive	Filinvest City	Muntinlupa	1781	Philippines	Prospect	Active	500.00
SALES-CUST-2025-303e3d	ACC-GLA-2025-65eca9	ADMIN-PARTNER-2025-3de538	Philippine General Hospital	Dr. Carlos Garcia	contact@pgh.gov.ph	+63-2-8554-8400	Taft Avenue	Ermita	Manila	1000	Philippines	Client	Active	2000.00
SALES-CUST-2025-e3832a	ACC-GLA-2025-91e0f2	ADMIN-PARTNER-2025-77a757	Manila Doctors Hospital	Mr. Luis Tan	support@maniladoctors.com.ph	+63-2-8558-0888	667 United Nations Avenue	Ermita	Manila	1000	Philippines	Client	Active	300.00
SALES-CUST-2025-bfc826	ACC-GLA-2025-be1609	ADMIN-PARTNER-2025-907d9c	Cardinal Santos Medical Center	Dr. Sofia Ramirez	info@cardinalsantos.com.ph	+63-2-8727-0001	10 Wilson Street	Greenhills	San Juan	1502	Philippines	Client	Active	750.00
SALES-CUST-2025-920ea7	ACC-GLA-2025-4d9b75	ADMIN-PARTNER-2025-4fb929	World Citi Medical Center	Ms. Patricia Go	billing@worldciti.com.ph	+63-2-8913-8380	960 Aurora Blvd	Cubao	Quezon City	1109	Philippines	Prospect	Active	500.00
SALES-CUST-2025-96421d	ACC-GLA-2025-1787a5	ADMIN-PARTNER-2025-ddeeeb	Davao Doctors Hospital	Dr. Miguel Torres	orders@davaodoctors.com.ph	+63-82-222-8000	118 E. Quirino Avenue	Poblacion	Davao City	8000	Philippines	Client	Active	650.00
SALES-CUST-2025-16f160	ACC-GLA-2025-eb1bda	ADMIN-PARTNER-2025-9f7334	Cebu Doctors University Hospital	Dr. Elena Wong	contact@cebudoctors.com.ph	+63-32-255-5555	Osmeña Boulevard	Capitol Site	Cebu City	6000	Philippines	Client	Active	0.00
SALES-CUST-2025-1ced77	ACC-GLA-2025-36c684	ADMIN-PARTNER-2025-5cc8c8	Metro Manila Medical Center	Mr. Daniel Lim	info@metromanilamed.com.ph	+63-2-8711-4141	1357 G. Masangkay Street	Binondo	Manila	1006	Philippines	Client	Active	1250.00
SALES-CUST-2025-393e34	ACC-GLA-2025-88b24e	ADMIN-PARTNER-2025-c9c2a8	East Avenue Medical Center	Dr. Andrea Cruz	contact@eastave.com.ph	+63-2-8928-0611	East Avenue	Diliman	Quezon City	1101	Philippines	Client	Active	950.00
SALES-CUST-2025-11316f	ACC-GLA-2025-efd9df	ADMIN-PARTNER-2025-39ba33	Capitol Medical Center	Ms. Grace Sy	support@capitolmedical.com.ph	+63-2-8372-3825	Quezon Avenue	Diliman	Quezon City	1101	Philippines	Client	Active	1800.00
SALES-CUST-2025-461682	ACC-GLA-2025-e6796a	ADMIN-PARTNER-2025-454ada	Ospital ng Makati	Dr. Mark Villanueva	info@ospitalngmakati.com.ph	+63-2-8828-8443	J.P. Rizal Avenue	Poblacion	Makati	1210	Philippines	Prospect	Active	600.00
SALES-CUST-2025-5ed6e4	ACC-GLA-2025-b92fbd	ADMIN-PARTNER-2025-611e15	Lung Center of the Philippines	Dr. Susan Chua	contact@lungcenter.com.ph	+63-2-8924-6101	Quezon Avenue	Diliman	Quezon City	1101	Philippines	Client	Active	0.00
SALES-CUST-2025-a5e198	ACC-GLA-2025-1e785f	ADMIN-PARTNER-2025-cacb02	National Kidney and Transplant Institute	Dr. Paul Chen	support@nkti.gov.ph	+63-2-8981-0300	East Avenue	Diliman	Quezon City	1100	Philippines	Client	Active	2300.00
SALES-CUST-2025-a1283c	ACC-GLA-2025-f0e93a	ADMIN-PARTNER-2025-dc9342	Rizal Medical Center	Ms. Lourdes Mendoza	info@rizalmed.com.ph	+63-2-8941-2911	Pasig Boulevard	Maybunga	Pasig	1607	Philippines	Client	Active	3000.00
SALES-CUST-2025-a53d8e	ACC-GLA-2025-3d3b62	ADMIN-PARTNER-2025-4cd806	Quirino Memorial Medical Center	Dr. Henry Ong	support@quirinomemorial.com.ph	+63-2-8913-7890	Katipunan Avenue	Project 4	Quezon City	1109	Philippines	Client	Active	700.00
SALES-CUST-2025-e1bf4f	ACC-GLA-2025-138639	ADMIN-PARTNER-2025-4fe472	Jose R. Reyes Memorial Medical Center	Dr. Carmen Lim	info@jrrmmc.gov.ph	+63-2-8731-3229	Rizal Avenue	Sta. Cruz	Manila	1003	Philippines	Prospect	Active	400.00
SALES-CUST-2025-6f4365	ACC-GLA-2025-32676a	ADMIN-PARTNER-2025-f45c1c	Perpetual Help Medical Center	Mr. Anthony Yu	contact@perpetualhelp.com.ph	+63-2-8871-0639	Alabang-Zapote Road	Pamplona	Las Piñas	1740	Philippines	Client	Active	1250.00
\.


--
-- Data for Name: delivery_note; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.delivery_note (delivery_note_id, order_id, statement_id, shipment_id, rework_id, shipping_method, tracking_num, preferred_delivery_date, shipping_date, estimated_delivery, actual_delivery_date, shipment_status, created_at) FROM stdin;
SALES-SHIP-2025-d475d0	\N	\N	\N	\N	Standard	asd10	2025-04-11	2023-03-15 00:00:00	2023-03-16 10:00:00	\N	Delivered	2025-04-01 17:08:48
SALES-SHIP-2025-50d9c4	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 18:16:26.064724
SALES-SHIP-2025-af6102	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 18:17:07.754678
SALES-SHIP-2025-8824b1	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 18:18:04.603952
SALES-SHIP-2025-2d2b3a	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 18:29:05.473124
SALES-SHIP-2025-fdd6dd	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 18:32:22.677136
SALES-SHIP-2025-e2f2cf	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 18:34:22.385346
SALES-SHIP-2025-0e46c6	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 18:36:56.841702
SALES-SHIP-2025-8bfbc7	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 19:03:38.941069
SALES-SHIP-2025-5825d2	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 19:13:08.624965
SALES-SHIP-2025-72adcd	\N	\N	\N	\N	Standard	\N	2025-04-11	\N	\N	\N	Pending	2025-04-01 16:49:04.4549
SALES-SHIP-2025-22a6bd	\N	\N	\N	\N	Standard	asd6	2025-04-11	2023-03-15 00:00:00	2023-03-16 10:00:00	\N	Delivered	2025-04-01 17:28:37
\.


--
-- Data for Name: opportunities; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.opportunities (opportunity_id, customer_id, partner_id, salesrep_id, estimated_value, weighted_amount, gross_profit_percentage, gross_profit_total, starting_date, expected_closed_date, stage, status, description, reason_lost, interest_level) FROM stdin;
SALES-OPP-2025-fc488a	\N	\N	\N	250000.00	200000.00	20.00	50000.00	2025-04-11 23:12:09.071108	2025-05-15	Prospecting	Open	Potential MRI scanner bulk order for hospital.	\N	High
SALES-OPP-2025-373491	\N	\N	\N	150000.00	120000.00	15.00	22500.00	2025-04-11 23:12:09.071108	2025-04-20	Negotiation	Open	Negotiating pricing for ventilators.	\N	Medium
SALES-OPP-2025-f9260c	\N	\N	\N	10000.00	9000.00	10.00	1000.00	2025-04-11 23:12:09.071108	2025-03-30	Closed	Won	Sold 500 surgical gloves.	\N	Low
SALES-OPP-2025-553682	\N	\N	\N	75000.00	60000.00	18.00	13500.00	2025-04-11 23:12:09.071108	2025-06-01	Prospecting	Open	New client interested in defibrillators.	\N	Medium
SALES-OPP-2025-8ab61c	\N	\N	\N	500000.00	450000.00	12.00	60000.00	2025-04-11 23:12:09.071108	2025-07-01	Negotiation	Lost	Large order for hospital beds.	Customer chose competitor.	High
SALES-OPP-2025-a1358f	\N	\N	\N	20000.00	18000.00	10.00	2000.00	2025-04-11 23:12:09.071108	2025-05-10	Closed	Won	Sold 200 syringes and 50 BP monitors.	\N	Low
SALES-OPP-2025-24fd53	\N	\N	\N	8000.00	7000.00	12.50	1000.00	2025-04-11 23:12:09.071108	2025-04-25	Closed	Lost	Small clinic interested in ECG machine.	Budget constraints.	Low
SALES-OPP-2025-723940	\N	\N	\N	95000.00	85000.00	15.00	14250.00	2025-04-11 23:12:09.071108	2025-05-20	Prospecting	Open	Potential deal for 3 new dialysis machines.	\N	Medium
SALES-OPP-2025-3ca9fd	\N	\N	\N	12000.00	10000.00	20.00	2400.00	2025-04-11 23:12:09.071108	2025-06-10	Negotiation	Open	Service maintenance contract for medical equipment.	\N	High
SALES-OPP-2025-da2e6a	\N	\N	\N	180000.00	160000.00	11.00	19800.00	2025-04-11 23:12:09.071108	2025-06-30	Closed	Won	Bulk order for surgical gloves and hospital furniture.	\N	Medium
SALES-OPP-2025-2d84c1	\N	\N	\N	300000.00	270000.00	10.00	30000.00	2025-04-11 23:12:09.071108	2025-06-15	Prospecting	Open	Potential deal for CT scanners.	\N	High
SALES-OPP-2025-f2b41e	\N	\N	\N	120000.00	110000.00	8.00	9600.00	2025-04-11 23:12:09.071108	2025-05-20	Negotiation	Open	Negotiating pricing for ultrasound machines.	\N	Medium
SALES-OPP-2025-bf28fc	\N	\N	\N	15000.00	14000.00	6.00	900.00	2025-04-11 23:12:09.071108	2025-04-30	Closed	Won	Sold 1000 surgical masks.	\N	Low
SALES-OPP-2025-1d9f4f	\N	\N	\N	90000.00	85000.00	5.00	4500.00	2025-04-11 23:12:09.071108	2025-07-01	Prospecting	Open	New client interested in MRI machines.	\N	Medium
SALES-OPP-2025-c2959e	\N	\N	\N	600000.00	550000.00	9.00	54000.00	2025-04-11 23:12:09.071108	2025-08-01	Negotiation	Lost	Large order for ventilators.	Customer chose competitor.	High
SALES-OPP-2025-3b333e	\N	\N	\N	25000.00	23000.00	7.00	1750.00	2025-04-11 23:12:09.071108	2025-06-10	Closed	Won	Sold 300 syringes and 100 BP monitors.	\N	Low
SALES-OPP-2025-6b80c1	\N	\N	\N	10000.00	8000.00	12.50	1250.00	2025-04-11 23:12:09.071108	2025-05-25	Closed	Lost	Small clinic interested in X-ray machine.	Budget constraints.	Low
SALES-OPP-2025-7d28fb	\N	\N	\N	110000.00	95000.00	14.00	15400.00	2025-04-11 23:12:09.071108	2025-06-20	Prospecting	Open	Potential deal for 5 new dialysis machines.	\N	Medium
SALES-OPP-2025-b42c09	\N	\N	\N	18000.00	16000.00	10.00	1800.00	2025-04-11 23:12:09.071108	2025-07-10	Negotiation	Open	Service maintenance contract for lab equipment.	\N	Medium
SALES-OPP-2025-5294a4	\N	\N	\N	200000.00	175000.00	12.00	24000.00	2025-04-11 23:12:09.071108	2025-07-30	Closed	Won	Bulk order for surgical gloves and hospital beds.	\N	High
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.orders (order_id, quotation_id, agreement_id, statement_id, ext_project_request_id, order_date, order_type) FROM stdin;
SALES-ORD-2025-c2f3ab	\N	\N	\N	\N	2025-04-01 16:48:44.151	Non-Project-Based
SALES-ORD-2025-441037	\N	\N	\N	\N	2025-04-01 16:52:52.331	Non-Project-Based
SALES-ORD-2025-72a45f	\N	\N	\N	\N	2025-04-01 18:06:52.553	Non-Project-Based
SALES-ORD-2025-4b3677	\N	\N	\N	\N	2025-04-01 18:16:19.127	Non-Project-Based
SALES-ORD-2025-53a470	\N	\N	\N	\N	2025-04-01 18:17:02.572	Non-Project-Based
SALES-ORD-2025-6484c7	\N	\N	\N	\N	2025-04-01 18:17:59.088	Non-Project-Based
SALES-ORD-2025-d3e940	\N	\N	\N	\N	2025-04-01 18:28:19.876	Non-Project-Based
SALES-ORD-2025-de59c9	\N	\N	\N	\N	2025-04-01 18:32:14.972	Non-Project-Based
SALES-ORD-2025-a07f25	\N	\N	\N	\N	2025-04-01 18:34:14.518	Non-Project-Based
SALES-ORD-2025-f9be31	\N	\N	\N	\N	2025-04-01 18:36:50.751	Non-Project-Based
SALES-ORD-2025-3e12b5	\N	\N	\N	\N	2025-04-01 19:03:28.694	Non-Project-Based
SALES-ORD-2025-172658	\N	\N	\N	\N	2025-04-01 19:12:43.354	Non-Project-Based
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.payments (payment_id, order_id, payment_method, payment_status, payment_date) FROM stdin;
\.


--
-- Data for Name: product_pricing; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.product_pricing (product_id, admin_product_id, markup_percentage, selling_price, demand_level) FROM stdin;
SALE-PRDP-2025-2a39f9	ADMIN-PROD-2025-fe6c97	20.00	57271.97	Low
SALE-PRDP-2025-c59ff1	ADMIN-PROD-2025-319fae	20.00	13141.44	Low
SALE-PRDP-2025-7166a3	ADMIN-PROD-2025-9c8bbf	20.00	1337599.20	Low
SALE-PRDP-2025-0d835c	ADMIN-PROD-2025-f1ad06	20.00	262080.00	Low
SALE-PRDP-2025-4a7259	ADMIN-PROD-2025-52bf2a	20.00	299707.20	Low
SALE-PRDP-2025-fad539	ADMIN-PROD-2025-b44bc9	20.00	162319.25	Low
SALE-PRDP-2025-2deeea	ADMIN-PROD-2025-7871b8	20.00	154440.00	Low
SALE-PRDP-2025-3364de	ADMIN-PROD-2025-aa1c8e	20.00	154440.00	Low
SALE-PRDP-2025-9b7165	ADMIN-PROD-2025-3f12a8	20.00	311452.13	Low
SALE-PRDP-2025-1f042a	ADMIN-PROD-2025-8e1a8d	20.00	262407.60	Low
SALE-PRDP-2025-85225a	ADMIN-PROD-2025-1dc59b	20.00	4745.52	Low
SALE-PRDP-2025-c39b47	ADMIN-PROD-2025-aa456d	20.00	4745.52	Low
SALE-PRDP-2025-34d16b	ADMIN-PROD-2025-abca9c	20.00	4745.52	Low
SALE-PRDP-2025-ab0492	ADMIN-PROD-2025-5e90b5	20.00	4745.52	Low
SALE-PRDP-2025-b82155	ADMIN-PROD-2025-b61a90	20.00	4745.52	Low
SALE-PRDP-2025-41ce90	ADMIN-PROD-2025-44afc4	20.00	4745.52	Low
SALE-PRDP-2025-74f211	ADMIN-PROD-2025-18b0e8	20.00	7291.44	Low
SALE-PRDP-2025-99fb71	ADMIN-PROD-2025-67e15f	20.00	12907.44	Low
SALE-PRDP-2025-bd8654	ADMIN-PROD-2025-93b1cb	20.00	4680.00	Low
SALE-PRDP-2025-0dd1c4	ADMIN-PROD-2025-5db948	20.00	2948.40	Low
SALE-PRDP-2025-d81ab4	ADMIN-PROD-2025-2aa802	20.00	38525.76	Low
SALE-PRDP-2025-85b7c2	ADMIN-PROD-2025-b42e3f	20.00	39948.48	Low
SALE-PRDP-2025-41a589	ADMIN-PROD-2025-9e5700	20.00	39948.48	Low
SALE-PRDP-2025-5b15f3	ADMIN-PROD-2025-0aee27	20.00	39948.48	Low
SALE-PRDP-2025-5559fc	ADMIN-PROD-2025-b5978f	20.00	1001.52	Low
SALE-PRDP-2025-481205	ADMIN-PROD-2025-f57a52	20.00	1001.52	Low
SALE-PRDP-2025-2ac114	ADMIN-PROD-2025-dbe3ca	20.00	936.00	Low
SALE-PRDP-2025-c04eec	ADMIN-PROD-2025-ca38e5	20.00	2246.40	Low
SALE-PRDP-2025-d9fe6b	ADMIN-PROD-2025-7a2c68	20.00	2246.40	Low
SALE-PRDP-2025-b716ab	ADMIN-PROD-2025-e891e0	20.00	6739.20	Low
\.


--
-- Data for Name: quotation; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.quotation (quotation_id, statement_id, agreement_id, date_issued) FROM stdin;
SALES-QT-2025-b00522	\N	\N	2025-04-01 16:48:29.339612
SALES-QT-2025-1fe7f5	\N	\N	2025-04-01 16:52:43.410282
SALES-QT-2025-ee7804	\N	\N	2025-04-01 18:16:12.587358
SALES-QT-2025-f40397	\N	\N	2025-04-01 18:16:57.598508
SALES-QT-2025-571da1	\N	\N	2025-04-01 18:17:40.617778
SALES-QT-2025-cf8b45	\N	\N	2025-04-01 18:28:11.232004
SALES-QT-2025-0dccaa	\N	\N	2025-04-01 18:32:09.394827
SALES-QT-2025-9abcb4	\N	\N	2025-04-01 18:33:28.142157
SALES-QT-2025-c9c649	\N	\N	2025-04-01 18:36:26.412221
SALES-QT-2025-ca13c4	\N	\N	2025-04-01 19:02:58.774078
SALES-QT-2025-fd735a	\N	\N	2025-04-01 19:12:08.301165
\.


--
-- Data for Name: return; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.return (return_id, statement_id, delivery_note_id, return_date, status, remarks) FROM stdin;
SALES-RTN-2025-ff1577	\N	\N	2024-03-01 10:00:00	Pending	Customer requested return
SALES-RTN-2025-8f393e	\N	\N	2024-03-02 11:15:00	Pending	Damaged item
SALES-RTN-2025-00cd90	\N	\N	2024-03-03 09:30:00	Pending	Incorrect order
SALES-RTN-2025-bd092f	\N	\N	2024-03-04 14:20:00	Pending	Customer changed mind
SALES-RTN-2025-3789f9	\N	\N	2024-03-05 16:45:00	Pending	Late delivery
SALES-RTN-2025-ce0358	\N	\N	2024-03-06 08:10:00	Pending	Quality issue
SALES-RTN-2025-d97970	\N	\N	2024-03-07 13:25:00	Pending	Wrong size
SALES-RTN-2025-8208f0	\N	\N	2024-03-08 12:40:00	Pending	Non-returnable item
SALES-RTN-2025-d8419e	\N	\N	2024-03-09 15:55:00	Pending	Item defect
SALES-RTN-2025-d2186d	\N	\N	2024-03-10 10:05:00	Pending	Wrong item shipped
SALES-RTN-2025-aa6443	\N	\N	2024-03-11 17:20:00	Pending	Received incomplete package
SALES-RTN-2025-3c12f9	\N	\N	2024-03-12 08:30:00	Pending	Return period expired
SALES-RTN-2025-72dfb8	\N	\N	2024-03-13 14:10:00	Pending	Product recall
SALES-RTN-2025-f62c6a	\N	\N	2024-03-14 12:50:00	Pending	Customer dissatisfaction
SALES-RTN-2025-31701c	\N	\N	2024-03-15 09:45:00	Pending	No valid reason
SALES-RTN-2025-42b2bd	\N	\N	2024-03-16 11:35:00	Pending	Missing parts
SALES-RTN-2025-031da7	\N	\N	2024-03-17 16:05:00	Pending	Delayed shipment
SALES-RTN-2025-384f7c	\N	\N	2024-03-18 13:15:00	Pending	Warranty claim
SALES-RTN-2025-9f5ca8	\N	\N	2024-03-19 10:50:00	Pending	Defective packaging
SALES-RTN-2025-c5cd17	\N	\N	2024-03-20 15:25:00	Pending	Opened package
\.


--
-- Data for Name: sales_invoices; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.sales_invoices (invoice_id, delivery_note_id, is_returned, invoice_date, total_amount, total_amount_paid) FROM stdin;
SALES-INV-2025-99f7fe	SALES-SHIP-2025-d475d0	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-e1591c	SALES-SHIP-2025-50d9c4	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-8fdf75	SALES-SHIP-2025-af6102	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-e25126	SALES-SHIP-2025-8824b1	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-9bad47	SALES-SHIP-2025-2d2b3a	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-f6a7d1	SALES-SHIP-2025-fdd6dd	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-bd9cce	SALES-SHIP-2025-e2f2cf	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-f27bfe	SALES-SHIP-2025-0e46c6	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-a09cf4	SALES-SHIP-2025-8bfbc7	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-7d6d3b	SALES-SHIP-2025-5825d2	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-0add56	SALES-SHIP-2025-72adcd	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-df4ef4	SALES-SHIP-2025-22a6bd	\N	2025-04-11 23:12:09.071108	\N	0.00
SALES-INV-2025-96706f	\N	\N	2025-04-01 16:49:04.4549	1897927.77	0.00
SALES-INV-2025-9492e2	\N	\N	2025-04-01 18:16:26.064724	1503426.09	0.00
SALES-INV-2025-88118c	\N	\N	2025-04-01 18:17:07.754678	64144.61	0.00
SALES-INV-2025-61195f	\N	\N	2025-04-01 18:18:04.603952	225828.97	0.00
SALES-INV-2025-c3c0be	\N	\N	2025-04-01 18:29:05.473124	335672.06	0.00
SALES-INV-2025-b8ba60	\N	\N	2025-04-01 18:32:22.677136	304306.33	0.00
SALES-INV-2025-dc5965	\N	\N	2025-04-01 18:34:22.385346	438495.89	0.00
SALES-INV-2025-1fa62d	\N	\N	2025-04-01 18:36:56.841702	1613013.93	0.00
SALES-INV-2025-7ce81a	\N	\N	2025-04-01 19:03:38.941069	1572785.17	0.00
SALES-INV-2025-739153	\N	\N	2025-04-01 19:13:08.624965	4319.98	0.00
SALES-INV-2025-0c6a7e	\N	\N	2025-04-01 17:28:37.855621	3702.21	3702.21
SALES-INV-2025-cc468f	\N	\N	2025-04-01 17:08:48.231566	1060371.04	300000.00
\.


--
-- Data for Name: statement; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.statement (statement_id, customer_id, salesrep_id, total_amount, discount, total_tax, created_at) FROM stdin;
SALES-STM-2025-e67b0d	\N	\N	1701942.83	0.00	167384.54	2025-04-01 13:51:53.570563
SALES-STM-2025-2e3535	\N	\N	1701942.83	0.00	167384.54	2025-04-01 13:53:44.852507
SALES-STM-2025-bd0f77	\N	\N	1701942.83	0.00	167384.54	2025-04-01 13:54:49.448863
SALES-STM-2025-d49a0e	\N	\N	1701942.83	0.00	167384.54	2025-04-01 13:55:24.472234
SALES-STM-2025-e08dc7	\N	\N	1701942.83	0.00	167384.54	2025-04-01 13:56:28.565793
SALES-STM-2025-3195ca	\N	\N	1701942.83	0.00	167384.54	2025-04-01 14:09:46.899058
SALES-STM-2025-25d0da	\N	\N	1701942.83	0.00	167384.54	2025-04-01 15:33:50.635766
SALES-STM-2025-40b556	\N	\N	2067385.61	0.00	203349.40	2025-04-01 16:48:29.321426
SALES-STM-2025-b3dc5e	\N	\N	1897927.77	0.00	203349.40	2025-04-01 16:48:44.199785
SALES-STM-2025-818285	\N	\N	1897927.77	0.00	203349.40	2025-04-01 16:49:04.4549
SALES-STM-2025-9d5d2a	\N	\N	1158208.35	0.00	113922.13	2025-04-01 16:52:43.389455
SALES-STM-2025-d1c862	\N	\N	1063273.24	0.00	113922.13	2025-04-01 16:52:52.379446
SALES-STM-2025-6bfa32	\N	\N	1059971.04	0.00	113568.33	2025-04-01 16:53:11.990171
SALES-STM-2025-4f4ad0	\N	\N	3302.21	0.00	353.81	2025-04-01 16:54:19.251878
SALES-STM-2025-932b36	\N	\N	1059971.04	0.00	113568.33	2025-04-01 17:08:48.231566
SALES-STM-2025-9d7119	\N	\N	3302.21	0.00	353.81	2025-04-01 17:11:50.082587
SALES-STM-2025-7c294d	\N	\N	3302.21	0.00	353.81	2025-04-01 17:28:37.855621
SALES-STM-2025-04948a	\N	\N	19629.60	0.00	1930.78	2025-04-01 18:06:49.330511
SALES-STM-2025-3de9ea	\N	\N	18020.62	0.00	1930.78	2025-04-01 18:06:52.599064
SALES-STM-2025-d6bb03	\N	\N	1637660.56	0.00	161081.37	2025-04-01 18:16:12.571195
SALES-STM-2025-53f4ce	\N	\N	1503426.09	0.00	161081.37	2025-04-01 18:16:19.285381
SALES-STM-2025-9d4d77	\N	\N	1503426.09	0.00	161081.37	2025-04-01 18:16:26.064724
SALES-STM-2025-9c637d	\N	\N	69871.81	0.00	6872.64	2025-04-01 18:16:57.583191
SALES-STM-2025-3ccba2	\N	\N	64144.61	0.00	6872.64	2025-04-01 18:17:02.73937
SALES-STM-2025-3166c9	\N	\N	64144.61	0.00	6872.64	2025-04-01 18:17:07.754678
SALES-STM-2025-f36788	\N	\N	256884.04	0.00	25267.28	2025-04-01 18:17:40.595599
SALES-STM-2025-ea7806	\N	\N	225828.97	9999.00	25267.28	2025-04-01 18:17:59.137843
SALES-STM-2025-8b6498	\N	\N	225828.97	9999.00	25267.28	2025-04-01 18:18:04.603952
SALES-STM-2025-f911ea	\N	\N	365642.78	0.00	35964.86	2025-04-01 18:28:11.21864
SALES-STM-2025-75ef8c	\N	\N	335672.06	0.00	35964.86	2025-04-01 18:28:19.933144
SALES-STM-2025-af71c1	\N	\N	335672.06	0.00	35964.86	2025-04-01 18:29:05.473124
SALES-STM-2025-ca9cdd	\N	\N	331476.54	0.00	32604.25	2025-04-01 18:32:09.373484
SALES-STM-2025-727828	\N	\N	304306.33	0.00	32604.25	2025-04-01 18:32:15.134312
SALES-STM-2025-4d416a	\N	\N	304306.33	0.00	32604.25	2025-04-01 18:32:22.677136
SALES-STM-2025-d020b9	\N	\N	526173.90	0.00	51754.81	2025-04-01 18:33:28.101904
SALES-STM-2025-5ff5fa	\N	\N	438495.89	44549.00	51754.81	2025-04-01 18:34:14.566532
SALES-STM-2025-3dfc2e	\N	\N	438495.89	44549.00	51754.81	2025-04-01 18:34:22.385346
SALES-STM-2025-9f227d	\N	\N	2014050.00	0.00	198103.28	2025-04-01 18:36:26.394095
SALES-STM-2025-e14ddd	\N	\N	1613013.93	235950.00	198103.28	2025-04-01 18:36:50.92362
SALES-STM-2025-3a80c9	\N	\N	1613013.93	235950.00	198103.28	2025-04-01 18:36:56.841702
SALES-STM-2025-d9a804	\N	\N	1572785.17	260998.00	196476.77	2025-04-01 19:02:58.747424
SALES-STM-2025-ffed64	\N	\N	1572785.17	260998.00	196476.77	2025-04-01 19:03:28.745651
SALES-STM-2025-41346f	\N	\N	1572785.17	260998.00	196476.77	2025-04-01 19:03:38.941069
SALES-STM-2025-ed24c9	\N	\N	4319.98	995.00	569.46	2025-04-01 19:12:08.284456
SALES-STM-2025-e01596	\N	\N	4319.98	995.00	569.46	2025-04-01 19:12:43.398919
SALES-STM-2025-c6a5a8	\N	\N	4319.98	995.00	569.46	2025-04-01 19:13:08.624965
\.


--
-- Data for Name: statement_item; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.statement_item (statement_item_id, statement_id, product_id, additional_service_id, quantity, quantity_to_deliver, unit_price, discount, total_price, tax_amount, special_requests, return_reason, return_action, quantity_delivered, created_at) FROM stdin;
SALES-STI-2025-dc05a0	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 13:51:13.50734
SALES-STI-2025-f707d9	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 13:51:13.50734
SALES-STI-2025-b08b71	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 13:53:44.242549
SALES-STI-2025-bb7eac	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 13:53:44.242549
SALES-STI-2025-1bf295	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 13:54:47.855611
SALES-STI-2025-d4ba2d	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 13:54:47.855611
SALES-STI-2025-e2c87a	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 13:55:12.558637
SALES-STI-2025-3888a3	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 13:55:12.558637
SALES-STI-2025-10c2e2	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 13:56:20.965966
SALES-STI-2025-87b9ed	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 13:56:20.965966
SALES-STI-2025-03fcf4	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 14:06:03.118627
SALES-STI-2025-f184c3	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 14:06:03.118627
SALES-STI-2025-f6beed	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	160511.90	\N	\N	\N	0	2025-04-01 15:32:19.17578
SALES-STI-2025-b4ef46	\N	\N	\N	1	1	57271.97	0.00	57271.97	6872.64	\N	\N	\N	0	2025-04-01 15:32:19.17578
SALES-STI-2025-366e80	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-4e0505	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-c0eab3	\N	\N	\N	1	1	299707.20	0.00	299707.20	0.00	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-3961e5	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-4c6786	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-0428d2	\N	\N	\N	1	1	299707.20	0.00	299707.20	0.00	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-e78019	\N	\N	\N	1	1	57271.97	0.00	57271.97	6872.64	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-c8765e	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	160511.90	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-7b02dc	\N	\N	\N	1	1	299707.20	0.00	299707.20	35964.86	\N	\N	\N	0	2025-04-01 16:38:39.988096
SALES-STI-2025-035578	\N	\N	\N	1	1	162319.25	0.00	162319.25	19478.31	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-6043c0	\N	\N	\N	2	2	311452.13	0.00	622904.26	74748.51	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-8bdf0b	\N	\N	\N	1	1	154440.00	0.00	154440.00	18532.80	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-4bd401	\N	\N	\N	1	1	6739.20	0.00	6739.20	808.70	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-0db915	\N	\N	\N	1	1	2948.40	0.00	2948.40	353.81	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-3b7ec3	\N	\N	\N	1	1	162319.25	0.00	162319.25	19478.31	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-39d9e5	\N	\N	\N	2	2	311452.13	0.00	622904.26	74748.51	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-ec0c21	\N	\N	\N	1	1	154440.00	0.00	154440.00	18532.80	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-339f3d	\N	\N	\N	1	1	6739.20	0.00	6739.20	808.70	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-248495	\N	\N	\N	1	1	2948.40	0.00	2948.40	353.81	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-816a50	\N	\N	\N	1	1	2948.40	0.00	2948.40	353.81	\N	\N	\N	0	2025-04-01 16:51:05.68012
SALES-STI-2025-447fbd	\N	\N	\N	1	1	162319.25	0.00	162319.25	19478.31	\N	\N	\N	1	2025-04-01 16:51:05.68012
SALES-STI-2025-49e251	\N	\N	\N	2	2	311452.13	0.00	622904.26	74748.51	\N	\N	\N	1	2025-04-01 16:51:05.68012
SALES-STI-2025-ebe678	\N	\N	\N	1	1	154440.00	0.00	154440.00	18532.80	\N	\N	\N	1	2025-04-01 16:51:05.68012
SALES-STI-2025-184d82	\N	\N	\N	1	1	6739.20	0.00	6739.20	808.70	\N	\N	\N	1	2025-04-01 16:51:05.68012
SALES-STI-2025-1b231c	\N	\N	\N	1	1	2948.40	0.00	2948.40	353.81	\N	\N	\N	0	2025-04-01 17:10:24.293349
SALES-STI-2025-6626ff	\N	\N	\N	1	1	2948.40	0.00	2948.40	353.81	\N	\N	\N	1	2025-04-01 17:27:38.77314
SALES-STI-2025-3ea890	\N	\N	\N	1	1	162319.25	9999.00	162319.25	19478.31	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-130ee3	\N	\N	\N	1	1	7291.44	0.00	7291.44	874.97	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-2fa1fb	\N	\N	\N	1	1	39948.48	0.00	39948.48	4793.82	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-41a779	\N	\N	\N	1	1	1001.52	0.00	1001.52	120.18	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-7b49a8	\N	\N	\N	1	1	162319.25	0.00	162319.25	19478.31	\N	\N	\N	2	2025-04-01 16:59:18.606144
SALES-STI-2025-5bddcb	\N	\N	\N	2	2	311452.13	0.00	622904.26	74748.51	\N	\N	\N	2	2025-04-01 16:59:18.606144
SALES-STI-2025-f710ec	\N	\N	\N	1	1	154440.00	0.00	154440.00	18532.80	\N	\N	\N	2	2025-04-01 16:59:18.606144
SALES-STI-2025-398fae	\N	\N	\N	1	1	6739.20	0.00	6739.20	808.70	\N	\N	\N	2	2025-04-01 16:59:18.606144
SALES-STI-2025-3a9e47	\N	\N	\N	1	1	13141.44	0.00	13141.44	0.00	\N	\N	\N	0	2025-04-01 17:39:33.036722
SALES-STI-2025-bf3c96	\N	\N	\N	1	1	2948.40	0.00	2948.40	0.00	\N	\N	\N	0	2025-04-01 17:39:33.036722
SALES-STI-2025-6a4589	\N	\N	\N	1	1	13141.44	0.00	13141.44	0.00	\N	\N	\N	0	2025-04-01 17:39:33.036722
SALES-STI-2025-47b0f6	\N	\N	\N	1	1	2948.40	0.00	2948.40	0.00	\N	\N	\N	0	2025-04-01 17:39:33.036722
SALES-STI-2025-34f1e4	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-d003e0	\N	\N	\N	1	1	4745.52	0.00	4745.52	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-20fb12	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-f0817c	\N	\N	\N	1	1	4745.52	0.00	4745.52	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-3a2b38	\N	\N	\N	1	1	1337599.20	0.00	1337599.20	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-8437b4	\N	\N	\N	1	1	4745.52	0.00	4745.52	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-43b4be	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-b66366	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-e86f5d	\N	\N	\N	1	1	57271.97	0.00	57271.97	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-a3150b	\N	\N	\N	1	1	162319.25	0.00	162319.25	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-82a6fb	\N	\N	\N	1	1	7291.44	0.00	7291.44	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-5030c1	\N	\N	\N	1	1	39948.48	0.00	39948.48	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-64aceb	\N	\N	\N	1	1	1001.52	0.00	1001.52	0.00	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-bbc3a9	\N	\N	\N	1	1	162319.25	9999.00	162319.25	19478.31	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-8b2e9f	\N	\N	\N	1	1	7291.44	0.00	7291.44	874.97	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-d9b626	\N	\N	\N	1	1	39948.48	0.00	39948.48	4793.82	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-7f8037	\N	\N	\N	1	1	1001.52	0.00	1001.52	120.18	\N	\N	\N	0	2025-04-01 18:07:20.136359
SALES-STI-2025-9f87ce	\N	\N	\N	1	1	299707.20	0.00	299707.20	0.00	\N	\N	\N	0	2025-04-01 18:26:42.453194
SALES-STI-2025-d720b7	\N	\N	\N	1	1	299707.20	0.00	299707.20	0.00	\N	\N	\N	0	2025-04-01 18:26:42.453194
SALES-STI-2025-792b3e	\N	\N	\N	1	1	299707.20	0.00	299707.20	0.00	\N	\N	\N	0	2025-04-01 18:26:42.453194
SALES-STI-2025-fa0966	\N	\N	\N	20	20	4745.52	0.00	94910.40	11389.25	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-9da1a9	\N	\N	\N	12	12	4745.52	0.00	56946.24	6833.55	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-ffa98d	\N	\N	\N	3	3	39948.48	0.00	119845.44	14381.45	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-24888c	\N	\N	\N	20	20	4745.52	0.00	94910.40	11389.25	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-664c92	\N	\N	\N	12	12	4745.52	0.00	56946.24	6833.55	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-864b27	\N	\N	\N	3	3	39948.48	0.00	119845.44	14381.45	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-a36f89	\N	\N	\N	20	20	4745.52	0.00	94910.40	11389.25	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-5d6530	\N	\N	\N	12	12	4745.52	0.00	56946.24	6833.55	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-0b7799	\N	\N	\N	3	3	39948.48	0.00	119845.44	14381.45	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-6e654e	\N	\N	\N	1	1	6739.20	0.00	6739.20	808.70	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-a39555	\N	\N	\N	13	13	13141.44	0.00	170838.72	20500.65	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-c304ef	\N	\N	\N	1	1	154440.00	0.00	154440.00	18532.80	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-0b533f	\N	\N	\N	4	4	12907.44	0.00	51629.76	6195.57	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-c82a6a	\N	\N	\N	1	1	4745.52	0.00	4745.52	0.00	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-b4d9dd	\N	\N	\N	1	1	39948.48	0.00	39948.48	0.00	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-e9a666	\N	\N	\N	1	1	2948.40	0.00	2948.40	0.00	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-e0507b	\N	\N	\N	1	1	6739.20	0.00	6739.20	808.70	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-1586c0	\N	\N	\N	13	13	13141.44	34550.00	170838.72	20500.65	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-e533ba	\N	\N	\N	1	1	154440.00	9999.00	154440.00	18532.80	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-372d2c	\N	\N	\N	4	4	12907.44	0.00	51629.76	6195.57	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-fad76e	\N	\N	\N	1	1	4745.52	0.00	4745.52	569.46	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-31bf57	\N	\N	\N	1	1	39948.48	0.00	39948.48	4793.82	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-ae30cb	\N	\N	\N	1	1	2948.40	0.00	2948.40	353.81	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-5be072	\N	\N	\N	1	1	6739.20	0.00	6739.20	808.70	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-c90e19	\N	\N	\N	13	13	13141.44	34550.00	170838.72	20500.65	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-20619e	\N	\N	\N	1	1	154440.00	9999.00	154440.00	18532.80	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-0b5670	\N	\N	\N	4	4	12907.44	0.00	51629.76	6195.57	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-f7c31b	\N	\N	\N	1	1	4745.52	0.00	4745.52	569.46	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-afcb07	\N	\N	\N	1	1	39948.48	0.00	39948.48	4793.82	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-59199d	\N	\N	\N	1	1	2948.40	0.00	2948.40	353.81	\N	\N	\N	0	2025-04-01 18:30:44.378415
SALES-STI-2025-e9ef86	\N	\N	\N	20	20	4680.00	0.00	93600.00	11232.00	\N	\N	\N	0	2025-04-01 18:35:25.770756
SALES-STI-2025-0ce1fd	\N	\N	\N	5	5	311452.13	0.00	1557260.65	186871.28	\N	\N	\N	0	2025-04-01 18:35:25.770756
SALES-STI-2025-fe8c8b	\N	\N	\N	20	20	4680.00	0.00	93600.00	11232.00	\N	\N	\N	0	2025-04-01 18:35:25.770756
SALES-STI-2025-6e7234	\N	\N	\N	5	5	311452.13	235950.00	1557260.65	186871.28	\N	\N	\N	0	2025-04-01 18:35:25.770756
SALES-STI-2025-581e47	\N	\N	\N	20	20	4680.00	0.00	93600.00	11232.00	\N	\N	\N	0	2025-04-01 18:35:25.770756
SALES-STI-2025-cbf00f	\N	\N	\N	5	5	311452.13	235950.00	1557260.65	186871.28	\N	\N	\N	0	2025-04-01 18:35:25.770756
SALES-STI-2025-2b42a3	\N	\N	\N	1	1	1337599.20	237999.00	1337599.20	160511.90	\N	\N	\N	0	2025-04-01 19:02:12.385792
SALES-STI-2025-e6055e	\N	\N	\N	1	1	299707.20	22999.00	299707.20	35964.86	\N	\N	\N	0	2025-04-01 19:02:12.385792
SALES-STI-2025-fd0e8f	\N	\N	\N	1	1	1337599.20	237999.00	1337599.20	160511.90	\N	\N	\N	0	2025-04-01 19:02:12.385792
SALES-STI-2025-16d871	\N	\N	\N	1	1	299707.20	22999.00	299707.20	35964.86	\N	\N	\N	0	2025-04-01 19:02:12.385792
SALES-STI-2025-afc9e2	\N	\N	\N	1	1	1337599.20	237999.00	1337599.20	160511.90	\N	\N	\N	0	2025-04-01 19:02:12.385792
SALES-STI-2025-e84247	\N	\N	\N	1	1	299707.20	22999.00	299707.20	35964.86	\N	\N	\N	0	2025-04-01 19:02:12.385792
SALES-STI-2025-d620ab	\N	\N	\N	1	1	4745.52	995.00	4745.52	569.46	\N	\N	\N	0	2025-04-01 19:09:10.344873
SALES-STI-2025-620046	\N	\N	\N	1	1	4745.52	995.00	4745.52	569.46	\N	\N	\N	0	2025-04-01 19:09:10.344873
SALES-STI-2025-015709	\N	\N	\N	1	1	4745.52	995.00	4745.52	569.46	\N	\N	\N	0	2025-04-01 19:09:10.344873
\.


--
-- Data for Name: ticket; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.ticket (ticket_id, customer_id, salesrep_id, subject, description, status, priority, type, created_at) FROM stdin;
SALES-TICKET-2025-683938	\N	\N	MRI Machine Maintenance	Scheduled preventive maintenance for MRI scanner.	Open	High	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-db890b	\N	\N	X-ray Calibration	X-ray machines require recalibration due to accuracy issues.	In Progress	Urgent	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-2d77ef	\N	\N	Training Request - ECG Machine	Hospital staff need hands-on training for ECG machines.	Open	Medium	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-8f6721	\N	\N	Software Update - Ventilators	Need to update ventilator software for new compliance regulations.	Closed	Low	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-706896	\N	\N	Warranty Repair - Defibrillator	Defibrillator malfunction under warranty claim.	Open	High	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-6bad3a	\N	\N	Technical Support - Ultrasound	Ultrasound machine displaying error code during operation.	In Progress	Medium	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-66e75e	\N	\N	Equipment Relocation Assistance	Need assistance in relocating an MRI scanner to another facility.	Closed	Low	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-13b217	\N	\N	Hospital Bed Malfunction	Motorized hospital beds not adjusting properly.	Open	Urgent	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-fa914a	\N	\N	Battery Replacement - Portable Monitors	Request to replace batteries for 20 portable patient monitors.	In Progress	High	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-e6afb9	\N	\N	On-Site Inspection - Operating Room Equipment	Request for technician visit to inspect all OR equipment.	Open	Medium	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-2ecafe	\N	\N	CT Scanner Calibration	CT scanner requires recalibration for accurate imaging.	Open	High	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-0879f4	\N	\N	Training Request - Ultrasound	Staff training needed for new ultrasound machines.	In Progress	Medium	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-075cd9	\N	\N	Warranty Repair - X-ray Machine	X-ray machine malfunction under warranty.	Open	Urgent	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-0ccce8	\N	\N	Software Update - MRI Scanner	MRI software update required for compliance.	Closed	Low	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-1f9a86	\N	\N	Equipment Relocation - Ventilators	Assistance needed to relocate ventilators.	Open	Medium	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-6b5d8c	\N	\N	Technical Support - Defibrillator	Defibrillator displaying error codes.	In Progress	High	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-49eaab	\N	\N	Hospital Bed Repair	Motorized hospital beds not functioning.	Closed	Low	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-82977a	\N	\N	Battery Replacement - Monitors	Request to replace batteries for patient monitors.	Open	Medium	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-71f862	\N	\N	On-Site Inspection - Lab Equipment	Inspection needed for lab equipment.	In Progress	High	\N	2025-04-11 23:12:09.071108
SALES-TICKET-2025-7434f2	\N	\N	Training Request - Surgical Tools	Training required for new surgical tools.	Open	Medium	\N	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: ticket_convo; Type: TABLE DATA; Schema: sales; Owner: postgres
--

COPY sales.ticket_convo (convo_id, ticket_id, subject, content, created_at) FROM stdin;
SALES-CONVO-2025-dd9e26	\N	\N	Technician scheduled for MRI maintenance on April 5.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-6e6545	\N	\N	Calibration tools dispatched, technician visit confirmed.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-f4d938	\N	\N	ECG training session scheduled for March 15.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-882d92	\N	\N	Software update package sent, remote installation guide provided.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-f8065d	\N	\N	Warranty repair approved, dispatching service team.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-f7fcfa	\N	\N	Ultrasound troubleshooting guide sent, remote support scheduled.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-e064b6	\N	\N	MRI relocation assistance team confirmed for March 20.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-fe0f19	\N	\N	Investigating motorized hospital bed issues, awaiting technician report.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-ec2392	\N	\N	Battery order placed, estimated arrival March 10.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-ede904	\N	\N	On-site inspection scheduled for April 1, report to follow.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-398a49	\N	\N	CT scanner calibration scheduled for April 10.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-203f82	\N	\N	Ultrasound training session confirmed for March 25.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-46f307	\N	\N	Warranty repair approved, technician dispatched.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-d7fb35	\N	\N	MRI software update completed remotely.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-3aa13e	\N	\N	Ventilator relocation team confirmed for April 5.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-d0c67e	\N	\N	Defibrillator troubleshooting guide sent.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-720cd0	\N	\N	Hospital bed repair completed successfully.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-2cee98	\N	\N	Battery replacement order placed, ETA March 15.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-9a6a9f	\N	\N	Lab equipment inspection scheduled for April 8.	2025-04-11 23:12:09.071108
SALES-CONVO-2025-efb23c	\N	\N	Surgical tools training session confirmed for March 30.	2025-04-11 23:12:09.071108
\.


--
-- Data for Name: additional_service; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.additional_service (additional_service_id, total_fee) FROM stdin;
SERVICES-ADDSER-2025-d51b87	150.00
SERVICES-ADDSER-2025-82ad2a	200.00
SERVICES-ADDSER-2025-7f1690	300.00
SERVICES-ADDSER-2025-24af96	250.00
SERVICES-ADDSER-2025-455d7a	100.00
SERVICES-ADDSER-2025-28d2de	180.00
SERVICES-ADDSER-2025-9530d4	220.00
SERVICES-ADDSER-2025-bf5d86	350.00
SERVICES-ADDSER-2025-150fa0	400.00
SERVICES-ADDSER-2025-5f7461	120.00
SERVICES-ADDSER-2025-1ae47a	160.00
SERVICES-ADDSER-2025-e698cb	210.00
SERVICES-ADDSER-2025-74e33d	280.00
SERVICES-ADDSER-2025-f9f188	230.00
SERVICES-ADDSER-2025-e3d853	270.00
SERVICES-ADDSER-2025-82ad27	300.00
SERVICES-ADDSER-2025-d9c5e4	320.00
SERVICES-ADDSER-2025-efae04	340.00
SERVICES-ADDSER-2025-9283b1	360.00
SERVICES-ADDSER-2025-5958e2	380.00
\.


--
-- Data for Name: additional_service_type; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.additional_service_type (additional_service_type_id, additional_service_id, service_type, service_fee, duration, date_start, status, total_service_fee) FROM stdin;
SERVICES-ADDSERTYPE-2025-a7217d	\N	Maintenance	50.00	6	2025-01-01	Active	300.00
SERVICES-ADDSERTYPE-2025-9c231d	\N	Extended Warranty	40.00	5	2025-02-01	Expired	200.00
SERVICES-ADDSERTYPE-2025-9ec30c	\N	Priority Service	60.00	4	2025-03-01	Active	240.00
SERVICES-ADDSERTYPE-2025-706c52	\N	Maintenance	55.00	6	2025-04-01	Expired	330.00
SERVICES-ADDSERTYPE-2025-983799	\N	Priority Service	75.00	7	2025-05-01	Active	525.00
SERVICES-ADDSERTYPE-2025-c229ab	\N	Extended Warranty	30.00	3	2025-06-01	Active	90.00
SERVICES-ADDSERTYPE-2025-6669d1	\N	Maintenance	65.00	6	2025-07-01	Expired	390.00
SERVICES-ADDSERTYPE-2025-973266	\N	Priority Service	80.00	5	2025-08-01	Active	400.00
SERVICES-ADDSERTYPE-2025-17b212	\N	Extended Warranty	45.00	8	2025-09-01	Active	360.00
SERVICES-ADDSERTYPE-2025-e9f1da	\N	Maintenance	70.00	6	2025-10-01	Expired	420.00
SERVICES-ADDSERTYPE-2025-522652	\N	Priority Service	50.00	4	2025-11-01	Active	200.00
SERVICES-ADDSERTYPE-2025-94fd3a	\N	Maintenance	60.00	6	2025-12-01	Active	360.00
SERVICES-ADDSERTYPE-2025-47da25	\N	Extended Warranty	65.00	5	2025-01-01	Expired	325.00
SERVICES-ADDSERTYPE-2025-2b7496	\N	Priority Service	90.00	7	2025-02-01	Active	630.00
SERVICES-ADDSERTYPE-2025-ca13b9	\N	Maintenance	55.00	4	2025-03-01	Expired	220.00
SERVICES-ADDSERTYPE-2025-0ff040	\N	Extended Warranty	50.00	6	2025-04-01	Active	300.00
SERVICES-ADDSERTYPE-2025-1fba81	\N	Priority Service	70.00	5	2025-05-01	Expired	350.00
SERVICES-ADDSERTYPE-2025-266bcc	\N	Maintenance	60.00	7	2025-06-01	Active	420.00
SERVICES-ADDSERTYPE-2025-5b92cf	\N	Extended Warranty	40.00	4	2025-07-01	Active	160.00
SERVICES-ADDSERTYPE-2025-a4fffe	\N	Priority Service	65.00	6	2025-08-01	Active	390.00
\.


--
-- Data for Name: after_analysis_sched; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.after_analysis_sched (analysis_sched_id, analysis_id, service_date, technician_id, description, service_status) FROM stdin;
SERVICES-SCHED-2025-959985	\N	2025-04-01	\N	Follow-up service scheduled after analysis.	Scheduled
SERVICES-SCHED-2025-792fbf	\N	2025-04-02	\N	Completed installation post-analysis.	Completed
SERVICES-SCHED-2025-d222e9	\N	2025-04-03	\N	Service cancelled due to client request.	Cancelled
SERVICES-SCHED-2025-a9668f	\N	2025-04-04	\N	Repair in progress based on findings.	In Progress
SERVICES-SCHED-2025-6a312e	\N	2025-04-05	\N	Scheduled check on replaced parts.	Scheduled
SERVICES-SCHED-2025-3f78a2	\N	2025-04-06	\N	System test completed successfully.	Completed
SERVICES-SCHED-2025-31b7c3	\N	2025-04-07	\N	Cancelled due to part unavailability.	Cancelled
SERVICES-SCHED-2025-b623df	\N	2025-04-08	\N	Service ongoing for thermal issues.	In Progress
SERVICES-SCHED-2025-ae1133	\N	2025-04-09	\N	Scheduled preventive maintenance.	Scheduled
SERVICES-SCHED-2025-279ab0	\N	2025-04-10	\N	Completed software patch deployment.	Completed
SERVICES-SCHED-2025-00140a	\N	2025-04-11	\N	Cancelled due to rescheduling.	Cancelled
SERVICES-SCHED-2025-bbbdb5	\N	2025-04-12	\N	Working on performance tuning.	In Progress
SERVICES-SCHED-2025-396bbd	\N	2025-04-13	\N	Follow-up scheduled after reboot fix.	Scheduled
SERVICES-SCHED-2025-fb1e49	\N	2025-04-14	\N	Completed minor repairs.	Completed
SERVICES-SCHED-2025-c43103	\N	2025-04-15	\N	Cancelled due to duplicate ticket.	Cancelled
SERVICES-SCHED-2025-e3a4c9	\N	2025-04-16	\N	In progress — diagnostics phase.	In Progress
SERVICES-SCHED-2025-a6f39a	\N	2025-04-17	\N	Scheduled hardware upgrade.	Scheduled
SERVICES-SCHED-2025-2992b5	\N	2025-04-18	\N	System restore and finalization done.	Completed
SERVICES-SCHED-2025-074321	\N	2025-04-19	\N	Cancelled — technician unavailable.	Cancelled
SERVICES-SCHED-2025-eafd56	\N	2025-04-20	\N	Currently working on solution.	In Progress
\.


--
-- Data for Name: delivery_order; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.delivery_order (delivery_order_id, service_order_id, customer_id, customer_address, delivery_status, delivery_date) FROM stdin;
SERVICES-DO-2025-9c89ca	\N	\N	123 Main St, Cityville, PH	Pending	2025-04-02
SERVICES-DO-2025-f64d44	\N	\N	456 Oak St, Townsville, PH	Shipped	2025-04-03
SERVICES-DO-2025-6c4b21	\N	\N	789 Pine St, Greenfield, PH	Delivered	2025-04-01
SERVICES-DO-2025-76e8d5	\N	\N	101 Maple St, Rivertown, PH	Pending	2025-04-05
SERVICES-DO-2025-dff78b	\N	\N	202 Birch St, Hilltop, PH	Shipped	2025-04-06
SERVICES-DO-2025-c01252	\N	\N	303 Cedar St, Seaview, PH	Delivered	2025-04-04
SERVICES-DO-2025-87513f	\N	\N	404 Elm St, Mountainview, PH	Pending	2025-04-07
SERVICES-DO-2025-1304bc	\N	\N	505 Walnut St, Lakeside, PH	Shipped	2025-04-08
SERVICES-DO-2025-f6b0e1	\N	\N	606 Ash St, Clearwater, PH	Delivered	2025-04-09
SERVICES-DO-2025-b86eb2	\N	\N	707 Cherry St, Sunshine, PH	Pending	2025-04-10
SERVICES-DO-2025-6c83fe	\N	\N	808 Magnolia St, Springdale, PH	Shipped	2025-04-11
SERVICES-DO-2025-00274d	\N	\N	909 Birchwood St, Foresthill, PH	Delivered	2025-04-12
SERVICES-DO-2025-aa5cf6	\N	\N	111 Pinecrest St, Parkview, PH	Pending	2025-04-13
SERVICES-DO-2025-34dbc3	\N	\N	222 Maplewood St, Hillview, PH	Shipped	2025-04-14
SERVICES-DO-2025-1eed0f	\N	\N	333 Oakwood St, Riverbend, PH	Delivered	2025-04-15
SERVICES-DO-2025-137da3	\N	\N	444 Redwood St, Pinehill, PH	Pending	2025-04-16
SERVICES-DO-2025-f01457	\N	\N	555 Cedarwood St, Grovecity, PH	Shipped	2025-04-17
SERVICES-DO-2025-03d5d6	\N	\N	666 Walnutwood St, Baytown, PH	Delivered	2025-04-18
SERVICES-DO-2025-20251e	\N	\N	777 Elmwood St, Highland, PH	Pending	2025-04-19
SERVICES-DO-2025-54f17b	\N	\N	888 Ashwood St, Seaside, PH	Shipped	2025-04-20
\.


--
-- Data for Name: service_analysis; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_analysis (analysis_id, service_request_id, analysis_date, technician_id, customer_id, analysis_status, analysis_description, product_id, contract_id, labor_cost) FROM stdin;
SERVICES-ANALYSIS-2025-0d928f	\N	2025-04-01	\N	\N	Scheduled	Initial diagnosis scheduled.	\N	\N	\N
SERVICES-ANALYSIS-2025-9e49f6	\N	2025-04-02	\N	\N	Done	Inspection completed. No issues found.	\N	\N	250.00
SERVICES-ANALYSIS-2025-0947de	\N	2025-04-03	\N	\N	Scheduled	Check for power issues.	\N	\N	\N
SERVICES-ANALYSIS-2025-fbfbf9	\N	2025-04-04	\N	\N	Done	Component replacement identified.	\N	\N	320.75
SERVICES-ANALYSIS-2025-9afcda	\N	2025-04-05	\N	\N	Scheduled	Noise analysis in system fan.	\N	\N	\N
SERVICES-ANALYSIS-2025-19b64d	\N	2025-04-06	\N	\N	Done	Hardware diagnostics run.	\N	\N	180.50
SERVICES-ANALYSIS-2025-c16f77	\N	2025-04-07	\N	\N	Scheduled	Testing network stability.	\N	\N	\N
SERVICES-ANALYSIS-2025-f9c28a	\N	2025-04-08	\N	\N	Done	Thermal issue confirmed.	\N	\N	220.00
SERVICES-ANALYSIS-2025-ecdb98	\N	2025-04-09	\N	\N	Scheduled	Check for software conflicts.	\N	\N	\N
SERVICES-ANALYSIS-2025-639b06	\N	2025-04-10	\N	\N	Done	Malware removed successfully.	\N	\N	150.00
SERVICES-ANALYSIS-2025-7061f6	\N	2025-04-11	\N	\N	Scheduled	Verify customer complaint.	\N	\N	\N
SERVICES-ANALYSIS-2025-a26741	\N	2025-04-12	\N	\N	Done	Battery failure found.	\N	\N	300.00
SERVICES-ANALYSIS-2025-b117a8	\N	2025-04-13	\N	\N	Scheduled	Sensor calibration check.	\N	\N	\N
SERVICES-ANALYSIS-2025-0c1a47	\N	2025-04-14	\N	\N	Done	System reboot resolved error.	\N	\N	100.00
SERVICES-ANALYSIS-2025-17d2aa	\N	2025-04-15	\N	\N	Scheduled	Analyze power surges.	\N	\N	\N
SERVICES-ANALYSIS-2025-3dcdff	\N	2025-04-16	\N	\N	Done	Data loss root cause identified.	\N	\N	275.00
SERVICES-ANALYSIS-2025-2b040f	\N	2025-04-17	\N	\N	Scheduled	Setup site analysis visit.	\N	\N	\N
SERVICES-ANALYSIS-2025-e196d9	\N	2025-04-18	\N	\N	Done	Improper wiring corrected.	\N	\N	350.00
SERVICES-ANALYSIS-2025-c0052f	\N	2025-04-19	\N	\N	Scheduled	Evaluate software errors.	\N	\N	\N
SERVICES-ANALYSIS-2025-f62e46	\N	2025-04-20	\N	\N	Done	Final system analysis finished.	\N	\N	400.00
\.


--
-- Data for Name: service_billing; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_billing (service_billing_id, service_order_id, renewal_id, analysis_id, service_request_id, service_billing_amount, outsource_fee, operational_cost_id, total_payable, billing_status, date_paid) FROM stdin;
SERVICES-BILL-2025-a71179	\N	\N	\N	\N	0.00	50.00	\N	50.00	Unpaid	\N
SERVICES-BILL-2025-a9cb30	\N	\N	\N	\N	0.00	30.00	\N	30.00	Paid	2025-04-05
SERVICES-BILL-2025-f4c11c	\N	\N	\N	\N	0.00	100.00	\N	100.00	Unpaid	\N
SERVICES-BILL-2025-bcfa96	\N	\N	\N	\N	0.00	200.00	\N	200.00	Paid	2025-04-06
SERVICES-BILL-2025-da3351	\N	\N	\N	\N	0.00	25.00	\N	25.00	Unpaid	\N
SERVICES-BILL-2025-1c4cdd	\N	\N	\N	\N	0.00	50.00	\N	50.00	Paid	2025-04-07
SERVICES-BILL-2025-f047a5	\N	\N	\N	\N	0.00	75.00	\N	75.00	Unpaid	\N
SERVICES-BILL-2025-8aae5c	\N	\N	\N	\N	0.00	20.00	\N	20.00	Paid	2025-04-08
SERVICES-BILL-2025-02db61	\N	\N	\N	\N	0.00	10.00	\N	10.00	Unpaid	\N
SERVICES-BILL-2025-ec1c61	\N	\N	\N	\N	0.00	45.00	\N	45.00	Paid	2025-04-09
SERVICES-BILL-2025-aa6ac1	\N	\N	\N	\N	0.00	15.00	\N	15.00	Unpaid	\N
SERVICES-BILL-2025-5b285f	\N	\N	\N	\N	0.00	60.00	\N	60.00	Paid	2025-04-10
SERVICES-BILL-2025-0e84de	\N	\N	\N	\N	0.00	100.00	\N	100.00	Unpaid	\N
SERVICES-BILL-2025-4842a0	\N	\N	\N	\N	0.00	35.00	\N	35.00	Paid	2025-04-11
SERVICES-BILL-2025-210ed5	\N	\N	\N	\N	0.00	10.00	\N	10.00	Unpaid	\N
SERVICES-BILL-2025-06e4f6	\N	\N	\N	\N	0.00	50.00	\N	50.00	Paid	2025-04-12
SERVICES-BILL-2025-37ff3a	\N	\N	\N	\N	0.00	75.00	\N	75.00	Unpaid	\N
SERVICES-BILL-2025-3b9b22	\N	\N	\N	\N	0.00	30.00	\N	30.00	Paid	2025-04-13
SERVICES-BILL-2025-c2ea37	\N	\N	\N	\N	0.00	25.00	\N	25.00	Unpaid	\N
SERVICES-BILL-2025-fbfcbb	\N	\N	\N	\N	0.00	60.00	\N	60.00	Paid	2025-04-14
\.


--
-- Data for Name: service_call; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_call (service_call_id, date_created, service_ticket_id, customer_id, call_type, technician_id, call_status, date_closed, contract_id, product_id, end_date, priority_level, resolution) FROM stdin;
SERVICES-CALL-2025-b6a1c5	2025-04-11 23:12:09.071108	\N	\N	Inquiry	\N	Open	\N	\N	\N	\N	Low	Pending customer info.
SERVICES-CALL-2025-5a75c6	2025-04-11 23:12:09.071108	\N	\N	Request	\N	Closed	2025-04-11 23:12:09.071108	\N	\N	2025-04-01	High	Issue resolved.
SERVICES-CALL-2025-f956c7	2025-04-11 23:12:09.071108	\N	\N	Other	\N	In Progress	\N	\N	\N	2025-04-03	Medium	Technician assigned.
SERVICES-CALL-2025-22f89c	2025-04-11 23:12:09.071108	\N	\N	Inquiry	\N	Open	\N	\N	\N	\N	Low	Awaiting technician.
SERVICES-CALL-2025-4a32bc	2025-04-11 23:12:09.071108	\N	\N	Request	\N	Closed	2025-04-11 23:12:09.071108	\N	\N	2025-03-29	High	Replaced defective part.
SERVICES-CALL-2025-811e3e	2025-04-11 23:12:09.071108	\N	\N	Other	\N	In Progress	\N	\N	\N	\N	Medium	Ongoing review.
SERVICES-CALL-2025-f94e6d	2025-04-11 23:12:09.071108	\N	\N	Inquiry	\N	Open	\N	\N	\N	\N	Low	Follow-up scheduled.
SERVICES-CALL-2025-f80949	2025-04-11 23:12:09.071108	\N	\N	Request	\N	Closed	2025-04-11 23:12:09.071108	\N	\N	2025-04-05	High	Resolved remotely.
SERVICES-CALL-2025-620105	2025-04-11 23:12:09.071108	\N	\N	Other	\N	In Progress	\N	\N	\N	\N	Medium	Waiting for tools.
SERVICES-CALL-2025-2359a1	2025-04-11 23:12:09.071108	\N	\N	Inquiry	\N	Open	\N	\N	\N	\N	Low	Initial contact made.
SERVICES-CALL-2025-51f888	2025-04-11 23:12:09.071108	\N	\N	Request	\N	Closed	2025-04-11 23:12:09.071108	\N	\N	2025-04-06	High	Customer satisfied.
SERVICES-CALL-2025-0b974d	2025-04-11 23:12:09.071108	\N	\N	Other	\N	In Progress	\N	\N	\N	\N	Medium	Parts ordered.
SERVICES-CALL-2025-d7f2be	2025-04-11 23:12:09.071108	\N	\N	Inquiry	\N	Open	\N	\N	\N	\N	Low	Ticket opened.
SERVICES-CALL-2025-9b9634	2025-04-11 23:12:09.071108	\N	\N	Request	\N	Closed	2025-04-11 23:12:09.071108	\N	\N	2025-03-30	High	Fixed in visit.
SERVICES-CALL-2025-065e8c	2025-04-11 23:12:09.071108	\N	\N	Other	\N	In Progress	\N	\N	\N	\N	Medium	Awaiting feedback.
SERVICES-CALL-2025-71967b	2025-04-11 23:12:09.071108	\N	\N	Inquiry	\N	Open	\N	\N	\N	\N	Low	To be diagnosed.
SERVICES-CALL-2025-5270c4	2025-04-11 23:12:09.071108	\N	\N	Request	\N	Closed	2025-04-11 23:12:09.071108	\N	\N	2025-04-02	High	Confirmed resolved.
SERVICES-CALL-2025-625d31	2025-04-11 23:12:09.071108	\N	\N	Other	\N	In Progress	\N	\N	\N	\N	Medium	Queued for support.
SERVICES-CALL-2025-ea5442	2025-04-11 23:12:09.071108	\N	\N	Inquiry	\N	Open	\N	\N	\N	\N	Low	Pending call back.
SERVICES-CALL-2025-3a5b59	2025-04-11 23:12:09.071108	\N	\N	Request	\N	Closed	2025-04-11 23:12:09.071108	\N	\N	2025-04-04	High	Closed with notes.
\.


--
-- Data for Name: service_contract; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_contract (contract_id, statement_item_id, customer_id, additional_service_id, contract_description, date_issued, end_date, product_id, contract_status, product_quantity, renewal_id, renewal_date, renewal_end_date) FROM stdin;
SERVICES-SERCON-2025-01979b	\N	\N	\N	Service contract for regular maintenance and updates of network infrastructure.	2025-01-01	2026-01-01	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-422b14	\N	\N	\N	Installation and support services for new office server setup.	2025-02-01	2026-02-01	\N	Pending	1	\N	\N	\N
SERVICES-SERCON-2025-005be6	\N	\N	\N	Annual warranty extension for office equipment and machinery.	2025-03-01	2026-03-01	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-e85a38	\N	\N	\N	Repair and maintenance of all computers in the company headquarters.	2025-04-01	2026-04-01	\N	Pending	1	\N	\N	\N
SERVICES-SERCON-2025-049532	\N	\N	\N	Contract for ongoing printer maintenance and supplies.	2025-05-01	2026-05-01	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-9e8db8	\N	\N	\N	Support and warranty renewal for all network devices.	2025-06-01	2026-06-01	\N	Expired	1	\N	2025-06-01	2026-06-01
SERVICES-SERCON-2025-2ad76d	\N	\N	\N	Emergency support services for critical equipment failure.	2025-07-01	2026-07-01	\N	Terminated	1	\N	2025-07-01	2026-07-01
SERVICES-SERCON-2025-44fae0	\N	\N	\N	Annual maintenance contract for software systems and updates.	2025-08-01	2026-08-01	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-3a1c56	\N	\N	\N	Office-wide internet service and connectivity package.	2025-09-01	2026-09-01	\N	Pending	1	\N	\N	\N
SERVICES-SERCON-2025-697926	\N	\N	\N	Support contract for all audiovisual equipment in conference rooms.	2025-10-01	2026-10-01	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-ff2127	\N	\N	\N	Comprehensive maintenance and support contract for all IT infrastructure.	2025-11-01	2026-11-01	\N	Pending	1	\N	\N	\N
SERVICES-SERCON-2025-b80705	\N	\N	\N	Renewal of service contract for cloud services and storage solutions.	2025-12-01	2026-12-01	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-71f67e	\N	\N	\N	On-site technical support and repairs for critical business operations.	2025-01-15	2026-01-15	\N	Pending	1	\N	\N	\N
SERVICES-SERCON-2025-d851d3	\N	\N	\N	Service contract for the setup and management of company-wide Wi-Fi systems.	2025-02-15	2026-02-15	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-d9c430	\N	\N	\N	Technical support for IT security systems and monitoring services.	2025-03-15	2026-03-15	\N	Pending	1	\N	\N	\N
SERVICES-SERCON-2025-21caec	\N	\N	\N	Repair and replacement service for office desktop computers.	2025-04-15	2026-04-15	\N	Active	1	\N	\N	\N
SERVICES-SERCON-2025-051c11	\N	\N	\N	Scheduled support for hardware upgrades and system optimizations.	2025-05-15	2026-05-15	\N	Expired	1	\N	2025-05-15	2026-05-15
SERVICES-SERCON-2025-21ecbc	\N	\N	\N	Support contract for the setup and monitoring of office security systems.	2025-06-15	2026-06-15	\N	Terminated	1	\N	2025-06-15	2026-06-15
\.


--
-- Data for Name: service_order; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_order (service_order_id, analysis_id, customer_id, order_date, order_total_price) FROM stdin;
SERVICES-SO-2025-cca544	\N	\N	2025-04-11 23:12:09.071108	1200.00
SERVICES-SO-2025-5b9112	\N	\N	2025-04-11 23:12:09.071108	950.75
SERVICES-SO-2025-0e4bfc	\N	\N	2025-04-11 23:12:09.071108	2100.50
SERVICES-SO-2025-4da94c	\N	\N	2025-04-11 23:12:09.071108	3300.00
SERVICES-SO-2025-a30683	\N	\N	2025-04-11 23:12:09.071108	785.25
SERVICES-SO-2025-a2ca42	\N	\N	2025-04-11 23:12:09.071108	1580.90
SERVICES-SO-2025-fdd1ec	\N	\N	2025-04-11 23:12:09.071108	2340.00
SERVICES-SO-2025-a19f71	\N	\N	2025-04-11 23:12:09.071108	999.99
SERVICES-SO-2025-9fc854	\N	\N	2025-04-11 23:12:09.071108	450.00
SERVICES-SO-2025-cc0aad	\N	\N	2025-04-11 23:12:09.071108	1275.40
SERVICES-SO-2025-ec26bd	\N	\N	2025-04-11 23:12:09.071108	880.00
SERVICES-SO-2025-02573e	\N	\N	2025-04-11 23:12:09.071108	1435.60
SERVICES-SO-2025-db36f1	\N	\N	2025-04-11 23:12:09.071108	3000.00
SERVICES-SO-2025-6afbec	\N	\N	2025-04-11 23:12:09.071108	1100.25
SERVICES-SO-2025-bf7df5	\N	\N	2025-04-11 23:12:09.071108	560.00
SERVICES-SO-2025-d47b9e	\N	\N	2025-04-11 23:12:09.071108	1995.95
SERVICES-SO-2025-42985d	\N	\N	2025-04-11 23:12:09.071108	2890.80
SERVICES-SO-2025-7dc9ae	\N	\N	2025-04-11 23:12:09.071108	615.35
SERVICES-SO-2025-f445ee	\N	\N	2025-04-11 23:12:09.071108	700.00
SERVICES-SO-2025-a852fb	\N	\N	2025-04-11 23:12:09.071108	1500.00
\.


--
-- Data for Name: service_order_item; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_order_item (service_order_item_id, service_order_id, item_id, principal_item_id, item_name, item_quantity, item_price) FROM stdin;
SOIT-2025-63aedf	\N	\N	\N	Laptop Repair	1	200.00
SOIT-2025-2dd2e8	\N	\N	\N	Router Installation	1	75.50
SOIT-2025-790dc7	\N	\N	\N	Software License	2	120.00
SOIT-2025-ed652a	\N	\N	\N	Monitor Replacement	1	300.00
SOIT-2025-7eea7f	\N	\N	\N	Keyboard Replacement	1	50.00
SOIT-2025-492757	\N	\N	\N	Hard Drive Upgrade	1	150.00
SOIT-2025-f2c509	\N	\N	\N	CPU Overhaul	1	250.00
SOIT-2025-9535d7	\N	\N	\N	System Diagnostic	1	80.00
SOIT-2025-f40472	\N	\N	\N	Battery Replacement	1	60.00
SOIT-2025-ded6f1	\N	\N	\N	Fan Replacement	2	45.00
SOIT-2025-1779af	\N	\N	\N	Printer Service	1	120.00
SOIT-2025-c09512	\N	\N	\N	Memory Upgrade	1	200.00
SOIT-2025-d09f7c	\N	\N	\N	Antivirus Software	3	90.00
SOIT-2025-ccf2e8	\N	\N	\N	SSD Upgrade	1	170.00
SOIT-2025-e8443e	\N	\N	\N	Graphics Card Installation	1	180.00
SOIT-2025-e5f88a	\N	\N	\N	Cables & Accessories	5	20.00
SOIT-2025-3adb69	\N	\N	\N	System Rebuild	1	350.00
SOIT-2025-582f83	\N	\N	\N	Data Recovery	1	220.00
SOIT-2025-3237a7	\N	\N	\N	Service Consultation	1	60.00
SOIT-2025-ab58f6	\N	\N	\N	Cloud Backup Setup	1	110.00
\.


--
-- Data for Name: service_report; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_report (report_id, service_call_id, service_ticket_id, service_billing_id, service_request_id, renewal_id, technician_id, description, report_status, request_type, submission_date) FROM stdin;
SERVICES-REPORT-2025-289632	\N	\N	\N	\N	\N	\N	Detailed repair of malfunctioning monitor	Draft	Repair	2025-04-01
SERVICES-REPORT-2025-e7f606	\N	\N	\N	\N	\N	\N	Installation of router at client site	Submitted	Installation	2025-04-02
SERVICES-REPORT-2025-f645e5	\N	\N	\N	\N	\N	\N	Routine maintenance of server farm	Reviewed	Maintenance	2025-04-03
SERVICES-REPORT-2025-bf207e	\N	\N	\N	\N	\N	\N	Urgent repair request for broken keyboard	Draft	Repair	2025-04-04
SERVICES-REPORT-2025-07a8ea	\N	\N	\N	\N	\N	\N	Installation of antivirus software	Submitted	Installation	2025-04-05
SERVICES-REPORT-2025-206459	\N	\N	\N	\N	\N	\N	Routine maintenance and software updates	Reviewed	Maintenance	2025-04-06
SERVICES-REPORT-2025-097c3a	\N	\N	\N	\N	\N	\N	Renewal of software license	Draft	Renewal	2025-04-07
SERVICES-REPORT-2025-b14fde	\N	\N	\N	\N	\N	\N	Replacement of malfunctioning router	Submitted	Repair	2025-04-08
SERVICES-REPORT-2025-a2ffcc	\N	\N	\N	\N	\N	\N	Upgrade of server hardware	Reviewed	Installation	2025-04-09
SERVICES-REPORT-2025-fe1c06	\N	\N	\N	\N	\N	\N	Initial maintenance checkup for new system	Draft	Maintenance	2025-04-10
SERVICES-REPORT-2025-e2d79d	\N	\N	\N	\N	\N	\N	Replacement of damaged hard drive	Submitted	Repair	2025-04-11
SERVICES-REPORT-2025-314c89	\N	\N	\N	\N	\N	\N	Installation of new printer at office	Reviewed	Installation	2025-04-12
SERVICES-REPORT-2025-24eeb7	\N	\N	\N	\N	\N	\N	Repair of desktop system not booting	Draft	Repair	2025-04-13
SERVICES-REPORT-2025-8b0aa4	\N	\N	\N	\N	\N	\N	Routine server cleanup and optimization	Submitted	Maintenance	2025-04-14
SERVICES-REPORT-2025-5e78a4	\N	\N	\N	\N	\N	\N	Renewal of office network equipment	Reviewed	Renewal	2025-04-15
SERVICES-REPORT-2025-91fd51	\N	\N	\N	\N	\N	\N	Software patch installation and update	Draft	Installation	2025-04-16
SERVICES-REPORT-2025-f8908c	\N	\N	\N	\N	\N	\N	System performance enhancement review	Submitted	Maintenance	2025-04-17
SERVICES-REPORT-2025-4d7785	\N	\N	\N	\N	\N	\N	Repair of defective graphics card	Reviewed	Repair	2025-04-18
SERVICES-REPORT-2025-fe52eb	\N	\N	\N	\N	\N	\N	Scheduled maintenance for email server	Draft	Maintenance	2025-04-19
\.


--
-- Data for Name: service_request; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.service_request (service_request_id, service_call_id, request_date, customer_id, technician_id, request_type, request_status, request_description, request_remarks) FROM stdin;
SERVICES-SR-2025-048072	\N	2025-04-01	\N	\N	Repair	Pending	Fixing screen issue.	Awaiting technician assignment.
SERVICES-SR-2025-8e2d74	\N	2025-04-02	\N	\N	Installation	Approved	Install new router.	Confirmed schedule.
SERVICES-SR-2025-824bef	\N	2025-04-03	\N	\N	Maintenance	In Progress	Quarterly maintenance check.	Ongoing process.
SERVICES-SR-2025-65fe52	\N	2025-04-04	\N	\N	Renewal	Rejected	Renew contract.	Missing documents.
SERVICES-SR-2025-74131c	\N	2025-04-05	\N	\N	Other	Pending	Custom service request.	Needs clarification.
SERVICES-SR-2025-f0861c	\N	2025-04-06	\N	\N	Repair	Approved	Replace motherboard.	Technician on route.
SERVICES-SR-2025-66e6a3	\N	2025-04-07	\N	\N	Installation	In Progress	Install CCTV system.	Equipment prepared.
SERVICES-SR-2025-3ef0b1	\N	2025-04-08	\N	\N	Maintenance	Rejected	Server cleanup.	Out of scope.
SERVICES-SR-2025-0f5ddd	\N	2025-04-09	\N	\N	Renewal	Pending	Extend service contract.	Waiting for payment.
SERVICES-SR-2025-713e6f	\N	2025-04-10	\N	\N	Other	Approved	On-site consultation.	Confirmed by team.
SERVICES-SR-2025-ec2411	\N	2025-04-11	\N	\N	Repair	Pending	Fix broken monitor.	Pending parts delivery.
SERVICES-SR-2025-4b3f1e	\N	2025-04-12	\N	\N	Installation	In Progress	Set up new workstations.	Technician deployed.
SERVICES-SR-2025-184890	\N	2025-04-13	\N	\N	Maintenance	Approved	Routine HVAC check.	Scheduled visit.
SERVICES-SR-2025-a9abc6	\N	2025-04-14	\N	\N	Renewal	In Progress	Subscription extension.	Processing request.
SERVICES-SR-2025-62f0d7	\N	2025-04-15	\N	\N	Other	Rejected	Non-standard task.	Cannot be fulfilled.
SERVICES-SR-2025-a77dc7	\N	2025-04-16	\N	\N	Repair	Approved	Repair printer issue.	Technician dispatched.
SERVICES-SR-2025-6b5a7d	\N	2025-04-17	\N	\N	Installation	Pending	Install new software.	Approval needed.
SERVICES-SR-2025-aa3857	\N	2025-04-18	\N	\N	Maintenance	Rejected	Database optimization.	No contract coverage.
SERVICES-SR-2025-d52b26	\N	2025-04-19	\N	\N	Renewal	Approved	Contract extension for 6 months.	Processed.
SERVICES-SR-2025-0922dc	\N	2025-04-20	\N	\N	Other	In Progress	Custom feature implementation.	Assigned to dev team.
\.


--
-- Data for Name: warranty_renewal; Type: TABLE DATA; Schema: services; Owner: postgres
--

COPY services.warranty_renewal (renewal_id, service_call_id, contract_id, duration, renewal_warranty_start, renewal_warranty_end, renewal_fee) FROM stdin;
SERVICES-RENEW-2025-bf8d8c	\N	\N	1	2025-01-01	2026-01-01	\N
SERVICES-RENEW-2025-e21abd	\N	\N	2	2025-02-01	2027-02-01	\N
SERVICES-RENEW-2025-448556	\N	\N	1	2025-03-01	2026-03-01	\N
SERVICES-RENEW-2025-b3c36e	\N	\N	3	2025-04-01	2028-04-01	\N
SERVICES-RENEW-2025-f16330	\N	\N	1	2025-05-01	2026-05-01	\N
SERVICES-RENEW-2025-896598	\N	\N	2	2025-06-01	2027-06-01	\N
SERVICES-RENEW-2025-03c9e8	\N	\N	1	2025-07-01	2026-07-01	\N
SERVICES-RENEW-2025-2da809	\N	\N	1	2025-08-01	2026-08-01	\N
SERVICES-RENEW-2025-06dbfe	\N	\N	3	2025-09-01	2028-09-01	\N
SERVICES-RENEW-2025-325b34	\N	\N	2	2025-10-01	2027-10-01	\N
SERVICES-RENEW-2025-c8f2d2	\N	\N	1	2025-11-01	2026-11-01	\N
SERVICES-RENEW-2025-126b46	\N	\N	2	2025-12-01	2027-12-01	\N
SERVICES-RENEW-2025-8eb9c9	\N	\N	1	2025-01-15	2026-01-15	\N
SERVICES-RENEW-2025-0d103b	\N	\N	3	2025-02-15	2028-02-15	\N
SERVICES-RENEW-2025-9541c5	\N	\N	1	2025-03-15	2026-03-15	\N
SERVICES-RENEW-2025-1f6943	\N	\N	2	2025-04-15	2027-04-15	\N
SERVICES-RENEW-2025-ce4ed8	\N	\N	1	2025-05-15	2026-05-15	\N
SERVICES-RENEW-2025-e7d29a	\N	\N	3	2025-06-15	2028-06-15	\N
SERVICES-RENEW-2025-964ab9	\N	\N	2	2025-07-15	2027-07-15	\N
\.


--
-- Name: ar_credit_memo_seq; Type: SEQUENCE SET; Schema: operations; Owner: postgres
--

SELECT pg_catalog.setval('operations.ar_credit_memo_seq', 21, true);


--
-- Name: asset_serial_seq; Type: SEQUENCE SET; Schema: operations; Owner: postgres
--

SELECT pg_catalog.setval('operations.asset_serial_seq', 20, true);


--
-- Name: batch_number_seq; Type: SEQUENCE SET; Schema: operations; Owner: postgres
--

SELECT pg_catalog.setval('operations.batch_number_seq', 20, true);


--
-- Name: chart_of_accounts chart_of_accounts_pkey; Type: CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.chart_of_accounts
    ADD CONSTRAINT chart_of_accounts_pkey PRIMARY KEY (account_code);


--
-- Name: financial_report financial_report_pkey; Type: CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.financial_report
    ADD CONSTRAINT financial_report_pkey PRIMARY KEY (report_id);


--
-- Name: general_ledger_accounts general_ledger_accounts_pkey; Type: CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.general_ledger_accounts
    ADD CONSTRAINT general_ledger_accounts_pkey PRIMARY KEY (gl_account_id);


--
-- Name: journal_entries journal_entries_pkey; Type: CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.journal_entries
    ADD CONSTRAINT journal_entries_pkey PRIMARY KEY (journal_id);


--
-- Name: journal_entry_lines journal_entry_lines_pkey; Type: CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.journal_entry_lines
    ADD CONSTRAINT journal_entry_lines_pkey PRIMARY KEY (entry_line_id);


--
-- Name: official_receipts official_receipts_pkey; Type: CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.official_receipts
    ADD CONSTRAINT official_receipts_pkey PRIMARY KEY (or_id);


--
-- Name: assets assets_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.assets
    ADD CONSTRAINT assets_pkey PRIMARY KEY (asset_id);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (log_id);


--
-- Name: business_partner_master business_partner_master_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.business_partner_master
    ADD CONSTRAINT business_partner_master_pkey PRIMARY KEY (partner_id);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (currency_id);


--
-- Name: item_master_data item_master_data_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.item_master_data
    ADD CONSTRAINT item_master_data_pkey PRIMARY KEY (item_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notifications_id);


--
-- Name: policies policies_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.policies
    ADD CONSTRAINT policies_pkey PRIMARY KEY (policy_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: raw_materials raw_materials_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.raw_materials
    ADD CONSTRAINT raw_materials_pkey PRIMARY KEY (material_id);


--
-- Name: roles_permission roles_permission_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.roles_permission
    ADD CONSTRAINT roles_permission_pkey PRIMARY KEY (role_id);


--
-- Name: users unique_employee; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.users
    ADD CONSTRAINT unique_employee UNIQUE (employee_id);


--
-- Name: business_partner_master uq_customer_id; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.business_partner_master
    ADD CONSTRAINT uq_customer_id UNIQUE (customer_id);


--
-- Name: business_partner_master uq_employee_id; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.business_partner_master
    ADD CONSTRAINT uq_employee_id UNIQUE (employee_id);


--
-- Name: business_partner_master uq_vendor_code; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.business_partner_master
    ADD CONSTRAINT uq_vendor_code UNIQUE (vendor_code);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: vendor vendor_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.vendor
    ADD CONSTRAINT vendor_pkey PRIMARY KEY (vendor_code);


--
-- Name: warehouse warehouse_pkey; Type: CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.warehouse
    ADD CONSTRAINT warehouse_pkey PRIMARY KEY (warehouse_id);


--
-- Name: billing_receipt billing_receipt_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.billing_receipt
    ADD CONSTRAINT billing_receipt_pkey PRIMARY KEY (billing_receipt_id);


--
-- Name: carrier carrier_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.carrier
    ADD CONSTRAINT carrier_pkey PRIMARY KEY (carrier_id);


--
-- Name: delivery_order delivery_order_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_order
    ADD CONSTRAINT delivery_order_pkey PRIMARY KEY (del_order_id);


--
-- Name: delivery_receipt delivery_receipt_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_receipt
    ADD CONSTRAINT delivery_receipt_pkey PRIMARY KEY (delivery_receipt_id);


--
-- Name: failed_shipment failed_shipment_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.failed_shipment
    ADD CONSTRAINT failed_shipment_pkey PRIMARY KEY (failed_shipment_id);


--
-- Name: goods_issue goods_issue_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.goods_issue
    ADD CONSTRAINT goods_issue_pkey PRIMARY KEY (goods_issue_id);


--
-- Name: logistics_approval_request logistics_approval_request_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.logistics_approval_request
    ADD CONSTRAINT logistics_approval_request_pkey PRIMARY KEY (approval_request_id);


--
-- Name: operational_cost operational_cost_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.operational_cost
    ADD CONSTRAINT operational_cost_pkey PRIMARY KEY (operational_cost_id);


--
-- Name: packing_cost packing_cost_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.packing_cost
    ADD CONSTRAINT packing_cost_pkey PRIMARY KEY (packing_cost_id);


--
-- Name: packing_list packing_list_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.packing_list
    ADD CONSTRAINT packing_list_pkey PRIMARY KEY (packing_list_id);


--
-- Name: picking_list picking_list_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.picking_list
    ADD CONSTRAINT picking_list_pkey PRIMARY KEY (picking_list_id);


--
-- Name: rejection rejection_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.rejection
    ADD CONSTRAINT rejection_pkey PRIMARY KEY (rejection_id);


--
-- Name: rework_order rework_order_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.rework_order
    ADD CONSTRAINT rework_order_pkey PRIMARY KEY (rework_id);


--
-- Name: shipment_details shipment_details_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.shipment_details
    ADD CONSTRAINT shipment_details_pkey PRIMARY KEY (shipment_id);


--
-- Name: shipping_cost shipping_cost_pkey; Type: CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.shipping_cost
    ADD CONSTRAINT shipping_cost_pkey PRIMARY KEY (shipping_cost_id);


--
-- Name: budget_allocation budget_allocation_pkey; Type: CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_allocation
    ADD CONSTRAINT budget_allocation_pkey PRIMARY KEY (budget_allocation_id);


--
-- Name: budget_approvals budget_approvals_pkey; Type: CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_approvals
    ADD CONSTRAINT budget_approvals_pkey PRIMARY KEY (budget_approvals_id);


--
-- Name: budget_request_form budget_request_form_pkey; Type: CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_request_form
    ADD CONSTRAINT budget_request_form_pkey PRIMARY KEY (budget_request_id);


--
-- Name: budget_returns_form budget_returns_form_pkey; Type: CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_returns_form
    ADD CONSTRAINT budget_returns_form_pkey PRIMARY KEY (budget_return_id);


--
-- Name: budget_submission budget_submission_pkey; Type: CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_submission
    ADD CONSTRAINT budget_submission_pkey PRIMARY KEY (budget_submission_id);


--
-- Name: budget_validations budget_validations_pkey; Type: CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_validations
    ADD CONSTRAINT budget_validations_pkey PRIMARY KEY (validation_id);


--
-- Name: attendance_tracking attendance_tracking_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.attendance_tracking
    ADD CONSTRAINT attendance_tracking_pkey PRIMARY KEY (attendance_id);


--
-- Name: calendar_dates calendar_dates_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.calendar_dates
    ADD CONSTRAINT calendar_dates_pkey PRIMARY KEY (date);


--
-- Name: candidates candidates_email_key; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.candidates
    ADD CONSTRAINT candidates_email_key UNIQUE (email);


--
-- Name: candidates candidates_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.candidates
    ADD CONSTRAINT candidates_pkey PRIMARY KEY (candidate_id);


--
-- Name: department_superiors department_superiors_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.department_superiors
    ADD CONSTRAINT department_superiors_pkey PRIMARY KEY (dept_id, position_id);


--
-- Name: departments departments_dept_name_key; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.departments
    ADD CONSTRAINT departments_dept_name_key UNIQUE (dept_name);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (dept_id);


--
-- Name: employee_leave_balances employee_leave_balances_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_leave_balances
    ADD CONSTRAINT employee_leave_balances_pkey PRIMARY KEY (balance_id);


--
-- Name: employee_performance employee_performance_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_performance
    ADD CONSTRAINT employee_performance_pkey PRIMARY KEY (performance_id);


--
-- Name: employee_salary employee_salary_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_salary
    ADD CONSTRAINT employee_salary_pkey PRIMARY KEY (salary_id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: job_posting job_posting_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_posting
    ADD CONSTRAINT job_posting_pkey PRIMARY KEY (job_id);


--
-- Name: leave_requests leave_requests_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.leave_requests
    ADD CONSTRAINT leave_requests_pkey PRIMARY KEY (leave_id);


--
-- Name: payroll payroll_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.payroll
    ADD CONSTRAINT payroll_pkey PRIMARY KEY (payroll_id);


--
-- Name: positions positions_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.positions
    ADD CONSTRAINT positions_pkey PRIMARY KEY (position_id);


--
-- Name: resignations resignations_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.resignations
    ADD CONSTRAINT resignations_pkey PRIMARY KEY (resignation_id);


--
-- Name: employee_leave_balances unique_employee_year; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_leave_balances
    ADD CONSTRAINT unique_employee_year UNIQUE (employee_id, year);


--
-- Name: workforce_allocation workforce_allocation_pkey; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.workforce_allocation
    ADD CONSTRAINT workforce_allocation_pkey PRIMARY KEY (allocation_id);


--
-- Name: workforce_allocation workforce_allocation_request_id_key; Type: CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.workforce_allocation
    ADD CONSTRAINT workforce_allocation_request_id_key UNIQUE (request_id);


--
-- Name: deprecation_report deprecation_report_pkey; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.deprecation_report
    ADD CONSTRAINT deprecation_report_pkey PRIMARY KEY (deprecation_report_id);


--
-- Name: expiry_report expiry_report_pkey; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.expiry_report
    ADD CONSTRAINT expiry_report_pkey PRIMARY KEY (expiry_report_id);


--
-- Name: inventory_adjustments inventory_adjustments_pkey; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_adjustments
    ADD CONSTRAINT inventory_adjustments_pkey PRIMARY KEY (adjustment_id);


--
-- Name: inventory_cyclic_counts inventory_cyclic_counts_pkey; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_cyclic_counts
    ADD CONSTRAINT inventory_cyclic_counts_pkey PRIMARY KEY (inventory_count_id);


--
-- Name: inventory_item inventory_item_pkey; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item
    ADD CONSTRAINT inventory_item_pkey PRIMARY KEY (inventory_item_id);


--
-- Name: inventory_item_threshold inventory_item_threshold_pkey; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item_threshold
    ADD CONSTRAINT inventory_item_threshold_pkey PRIMARY KEY (inventory_item_threshold_id);


--
-- Name: warehouse_movement_items pk_warehouse_movement_items; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement_items
    ADD CONSTRAINT pk_warehouse_movement_items PRIMARY KEY (movement_id, inventory_item_id);


--
-- Name: warehouse_movement warehouse_movement_pkey; Type: CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement
    ADD CONSTRAINT warehouse_movement_pkey PRIMARY KEY (movement_id);


--
-- Name: management_approvals management_approvals_pkey; Type: CONSTRAINT; Schema: management; Owner: postgres
--

ALTER TABLE ONLY management.management_approvals
    ADD CONSTRAINT management_approvals_pkey PRIMARY KEY (approval_id);


--
-- Name: bill_of_materials bill_of_materials_pkey; Type: CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.bill_of_materials
    ADD CONSTRAINT bill_of_materials_pkey PRIMARY KEY (bom_id);


--
-- Name: labor_cost labor_cost_pkey; Type: CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.labor_cost
    ADD CONSTRAINT labor_cost_pkey PRIMARY KEY (labor_cost_id);


--
-- Name: non_project_order_pricing non_project_order_pricing_pkey; Type: CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.non_project_order_pricing
    ADD CONSTRAINT non_project_order_pricing_pkey PRIMARY KEY (non_project_costing_id);


--
-- Name: principal_items principal_items_pkey; Type: CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.principal_items
    ADD CONSTRAINT principal_items_pkey PRIMARY KEY (principal_item_id);


--
-- Name: product_mats product_mats_pkey; Type: CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.product_mats
    ADD CONSTRAINT product_mats_pkey PRIMARY KEY (product_mats_id);


--
-- Name: document_header document_header_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.document_header
    ADD CONSTRAINT document_header_pkey PRIMARY KEY (document_id);


--
-- Name: document_items document_items_batch_no_key; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.document_items
    ADD CONSTRAINT document_items_batch_no_key UNIQUE (batch_no);


--
-- Name: document_items document_items_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.document_items
    ADD CONSTRAINT document_items_pkey PRIMARY KEY (content_id);


--
-- Name: external_module external_module_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.external_module
    ADD CONSTRAINT external_module_pkey PRIMARY KEY (external_id);


--
-- Name: product_document_items product_document_items_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.product_document_items
    ADD CONSTRAINT product_document_items_pkey PRIMARY KEY (productdocu_id);


--
-- Name: serial_tracking serial_tracking_pkey; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.serial_tracking
    ADD CONSTRAINT serial_tracking_pkey PRIMARY KEY (serial_id);


--
-- Name: serial_tracking serial_tracking_serial_no_key; Type: CONSTRAINT; Schema: operations; Owner: postgres
--

ALTER TABLE ONLY operations.serial_tracking
    ADD CONSTRAINT serial_tracking_serial_no_key UNIQUE (serial_no);


--
-- Name: equipment equipment_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (equipment_id);


--
-- Name: labor labor_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.labor
    ADD CONSTRAINT labor_pkey PRIMARY KEY (labor_id);


--
-- Name: production_orders_details production_orders_details_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.production_orders_details
    ADD CONSTRAINT production_orders_details_pkey PRIMARY KEY (production_order_detail_id);


--
-- Name: production_orders_header production_orders_header_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.production_orders_header
    ADD CONSTRAINT production_orders_header_pkey PRIMARY KEY (production_order_id);


--
-- Name: project_equipment project_equipment_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.project_equipment
    ADD CONSTRAINT project_equipment_pkey PRIMARY KEY (project_equipment_id);


--
-- Name: rework_cost rework_cost_pkey; Type: CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.rework_cost
    ADD CONSTRAINT rework_cost_pkey PRIMARY KEY (rework_cost_id);


--
-- Name: external_project_cost_management external_project_cost_management_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_cost_management
    ADD CONSTRAINT external_project_cost_management_pkey PRIMARY KEY (project_resources_id);


--
-- Name: external_project_details external_project_details_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_details
    ADD CONSTRAINT external_project_details_pkey PRIMARY KEY (project_id);


--
-- Name: external_project_equipments external_project_equipments_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_equipments
    ADD CONSTRAINT external_project_equipments_pkey PRIMARY KEY (project_equipment_list_id);


--
-- Name: external_project_labor external_project_labor_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_labor
    ADD CONSTRAINT external_project_labor_pkey PRIMARY KEY (project_labor_id);


--
-- Name: external_project_request external_project_request_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_request
    ADD CONSTRAINT external_project_request_pkey PRIMARY KEY (ext_project_request_id);


--
-- Name: external_project_task_list external_project_task_list_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_task_list
    ADD CONSTRAINT external_project_task_list_pkey PRIMARY KEY (task_id);


--
-- Name: external_project_tracking external_project_tracking_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_tracking
    ADD CONSTRAINT external_project_tracking_pkey PRIMARY KEY (project_tracking_id);


--
-- Name: external_project_warranty external_project_warranty_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_warranty
    ADD CONSTRAINT external_project_warranty_pkey PRIMARY KEY (project_warranty_id);


--
-- Name: internal_project_cost_management internal_project_cost_management_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_cost_management
    ADD CONSTRAINT internal_project_cost_management_pkey PRIMARY KEY (intrnl_project_resources_id);


--
-- Name: internal_project_details internal_project_details_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_details
    ADD CONSTRAINT internal_project_details_pkey PRIMARY KEY (intrnl_project_id);


--
-- Name: internal_project_labor internal_project_labor_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_labor
    ADD CONSTRAINT internal_project_labor_pkey PRIMARY KEY (intrnl_project_labor_id);


--
-- Name: internal_project_request internal_project_request_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_request
    ADD CONSTRAINT internal_project_request_pkey PRIMARY KEY (project_request_id);


--
-- Name: internal_project_task_list internal_project_task_list_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_task_list
    ADD CONSTRAINT internal_project_task_list_pkey PRIMARY KEY (intrnl_task_id);


--
-- Name: internal_project_tracking internal_project_tracking_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_tracking
    ADD CONSTRAINT internal_project_tracking_pkey PRIMARY KEY (intrnl_project_tracking_id);


--
-- Name: report_monitoring report_monitoring_pkey; Type: CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.report_monitoring
    ADD CONSTRAINT report_monitoring_pkey PRIMARY KEY (report_monitoring_id);


--
-- Name: batch_inspection batch_inspection_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.batch_inspection
    ADD CONSTRAINT batch_inspection_pkey PRIMARY KEY (inspection_id);


--
-- Name: credit_memo credit_memo_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.credit_memo
    ADD CONSTRAINT credit_memo_pkey PRIMARY KEY (credit_memo_id);


--
-- Name: purchase_invoice purchase_invoice_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_invoice
    ADD CONSTRAINT purchase_invoice_pkey PRIMARY KEY (invoice_id);


--
-- Name: purchase_order purchase_order_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order
    ADD CONSTRAINT purchase_order_pkey PRIMARY KEY (purchase_id);


--
-- Name: purchase_quotation purchase_quotation_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_quotation
    ADD CONSTRAINT purchase_quotation_pkey PRIMARY KEY (quotation_id);


--
-- Name: purchase_requests purchase_requests_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_requests
    ADD CONSTRAINT purchase_requests_pkey PRIMARY KEY (request_id);


--
-- Name: quotation_contents quotation_contents_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.quotation_contents
    ADD CONSTRAINT quotation_contents_pkey PRIMARY KEY (quotation_content_id);


--
-- Name: received_shipments received_shipments_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.received_shipments
    ADD CONSTRAINT received_shipments_pkey PRIMARY KEY (shipment_id);


--
-- Name: vendor_application vendor_application_pkey; Type: CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.vendor_application
    ADD CONSTRAINT vendor_application_pkey PRIMARY KEY (application_reference);


--
-- Name: blanket_agreement blanket_agreement_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.blanket_agreement
    ADD CONSTRAINT blanket_agreement_pkey PRIMARY KEY (agreement_id);


--
-- Name: campaign_contacts campaign_contacts_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.campaign_contacts
    ADD CONSTRAINT campaign_contacts_pkey PRIMARY KEY (contact_id);


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.campaigns
    ADD CONSTRAINT campaigns_pkey PRIMARY KEY (campaign_id);


--
-- Name: customers customers_email_address_key; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customers
    ADD CONSTRAINT customers_email_address_key UNIQUE (email_address);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (customer_id);


--
-- Name: delivery_note delivery_note_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.delivery_note
    ADD CONSTRAINT delivery_note_pkey PRIMARY KEY (delivery_note_id);


--
-- Name: opportunities opportunities_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.opportunities
    ADD CONSTRAINT opportunities_pkey PRIMARY KEY (opportunity_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: product_pricing product_pricing_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.product_pricing
    ADD CONSTRAINT product_pricing_pkey PRIMARY KEY (product_id);


--
-- Name: quotation quotation_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.quotation
    ADD CONSTRAINT quotation_pkey PRIMARY KEY (quotation_id);


--
-- Name: return return_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.return
    ADD CONSTRAINT return_pkey PRIMARY KEY (return_id);


--
-- Name: sales_invoices sales_invoices_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_invoices
    ADD CONSTRAINT sales_invoices_pkey PRIMARY KEY (invoice_id);


--
-- Name: statement_item statement_item_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.statement_item
    ADD CONSTRAINT statement_item_pkey PRIMARY KEY (statement_item_id);


--
-- Name: statement statement_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.statement
    ADD CONSTRAINT statement_pkey PRIMARY KEY (statement_id);


--
-- Name: ticket_convo ticket_convo_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.ticket_convo
    ADD CONSTRAINT ticket_convo_pkey PRIMARY KEY (convo_id);


--
-- Name: ticket ticket_pkey; Type: CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.ticket
    ADD CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id);


--
-- Name: additional_service additional_service_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.additional_service
    ADD CONSTRAINT additional_service_pkey PRIMARY KEY (additional_service_id);


--
-- Name: additional_service_type additional_service_type_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.additional_service_type
    ADD CONSTRAINT additional_service_type_pkey PRIMARY KEY (additional_service_type_id);


--
-- Name: after_analysis_sched after_analysis_sched_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.after_analysis_sched
    ADD CONSTRAINT after_analysis_sched_pkey PRIMARY KEY (analysis_sched_id);


--
-- Name: delivery_order delivery_order_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.delivery_order
    ADD CONSTRAINT delivery_order_pkey PRIMARY KEY (delivery_order_id);


--
-- Name: service_analysis service_analysis_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_analysis
    ADD CONSTRAINT service_analysis_pkey PRIMARY KEY (analysis_id);


--
-- Name: service_billing service_billing_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_billing
    ADD CONSTRAINT service_billing_pkey PRIMARY KEY (service_billing_id);


--
-- Name: service_call service_call_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_call
    ADD CONSTRAINT service_call_pkey PRIMARY KEY (service_call_id);


--
-- Name: service_contract service_contract_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_contract
    ADD CONSTRAINT service_contract_pkey PRIMARY KEY (contract_id);


--
-- Name: service_order_item service_order_item_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_order_item
    ADD CONSTRAINT service_order_item_pkey PRIMARY KEY (service_order_item_id);


--
-- Name: service_order service_order_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_order
    ADD CONSTRAINT service_order_pkey PRIMARY KEY (service_order_id);


--
-- Name: service_report service_report_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_report
    ADD CONSTRAINT service_report_pkey PRIMARY KEY (report_id);


--
-- Name: service_request service_request_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_request
    ADD CONSTRAINT service_request_pkey PRIMARY KEY (service_request_id);


--
-- Name: warranty_renewal warranty_renewal_pkey; Type: CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.warranty_renewal
    ADD CONSTRAINT warranty_renewal_pkey PRIMARY KEY (renewal_id);


--
-- Name: chart_of_accounts audit_generic_chart_of_accounts; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER audit_generic_chart_of_accounts AFTER INSERT OR DELETE OR UPDATE ON accounting.chart_of_accounts FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: financial_report audit_generic_financial_report; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER audit_generic_financial_report AFTER INSERT OR DELETE OR UPDATE ON accounting.financial_report FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: general_ledger_accounts audit_generic_general_ledger_accounts; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER audit_generic_general_ledger_accounts AFTER INSERT OR DELETE OR UPDATE ON accounting.general_ledger_accounts FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: journal_entries audit_generic_journal_entries; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER audit_generic_journal_entries AFTER INSERT OR DELETE OR UPDATE ON accounting.journal_entries FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: journal_entry_lines audit_generic_journal_entry_lines; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER audit_generic_journal_entry_lines AFTER INSERT OR DELETE OR UPDATE ON accounting.journal_entry_lines FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: official_receipts audit_generic_official_receipts; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER audit_generic_official_receipts AFTER INSERT OR DELETE OR UPDATE ON accounting.official_receipts FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: financial_report before_insert_financial_report; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER before_insert_financial_report BEFORE INSERT ON accounting.financial_report FOR EACH ROW EXECUTE FUNCTION accounting.generate_report_id();


--
-- Name: general_ledger_accounts before_insert_general_ledger_accounts; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER before_insert_general_ledger_accounts BEFORE INSERT ON accounting.general_ledger_accounts FOR EACH ROW EXECUTE FUNCTION accounting.generate_gl_account_id();


--
-- Name: journal_entries before_insert_journal_entries; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER before_insert_journal_entries BEFORE INSERT ON accounting.journal_entries FOR EACH ROW EXECUTE FUNCTION accounting.generate_journal_id();


--
-- Name: journal_entry_lines before_insert_journal_entry_lines; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER before_insert_journal_entry_lines BEFORE INSERT ON accounting.journal_entry_lines FOR EACH ROW EXECUTE FUNCTION accounting.generate_entry_line_id();


--
-- Name: official_receipts before_insert_official_receipts; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER before_insert_official_receipts BEFORE INSERT ON accounting.official_receipts FOR EACH ROW EXECUTE FUNCTION accounting.generate_or_id();


--
-- Name: official_receipts trigger_receipt_journal; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER trigger_receipt_journal AFTER INSERT ON accounting.official_receipts FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_receipt();


--
-- Name: official_receipts trigger_second_payment_full_settlement; Type: TRIGGER; Schema: accounting; Owner: postgres
--

CREATE TRIGGER trigger_second_payment_full_settlement AFTER UPDATE ON accounting.official_receipts FOR EACH ROW WHEN (((new.remaining_amount = (0)::numeric) AND (old.remaining_amount > (0)::numeric))) EXECUTE FUNCTION accounting.create_journal_entry_for_second_payment();


--
-- Name: assets audit_generic_assets; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_assets AFTER INSERT OR DELETE OR UPDATE ON admin.assets FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: business_partner_master audit_generic_business_partner_master; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_business_partner_master AFTER INSERT OR DELETE OR UPDATE ON admin.business_partner_master FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: currency audit_generic_currency; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_currency AFTER INSERT OR DELETE OR UPDATE ON admin.currency FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: item_master_data audit_generic_item_master_data; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_item_master_data AFTER INSERT OR DELETE OR UPDATE ON admin.item_master_data FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: notifications audit_generic_notifications; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_notifications AFTER INSERT OR DELETE OR UPDATE ON admin.notifications FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: policies audit_generic_policies; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_policies AFTER INSERT OR DELETE OR UPDATE ON admin.policies FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: products audit_generic_products; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_products AFTER INSERT OR DELETE OR UPDATE ON admin.products FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: raw_materials audit_generic_raw_materials; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_raw_materials AFTER INSERT OR DELETE OR UPDATE ON admin.raw_materials FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: roles_permission audit_generic_roles_permission; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_roles_permission AFTER INSERT OR DELETE OR UPDATE ON admin.roles_permission FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: users audit_generic_users; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_users AFTER INSERT OR DELETE OR UPDATE ON admin.users FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: vendor audit_generic_vendor; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_vendor AFTER INSERT OR DELETE OR UPDATE ON admin.vendor FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: warehouse audit_generic_warehouse; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER audit_generic_warehouse AFTER INSERT OR DELETE OR UPDATE ON admin.warehouse FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: assets before_insert_asset; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_asset BEFORE INSERT ON admin.assets FOR EACH ROW EXECUTE FUNCTION admin.generate_asset_id();


--
-- Name: audit_log before_insert_audit_log; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_audit_log BEFORE INSERT ON admin.audit_log FOR EACH ROW EXECUTE FUNCTION admin.generate_log_id();


--
-- Name: business_partner_master before_insert_business_partner_master; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_business_partner_master BEFORE INSERT ON admin.business_partner_master FOR EACH ROW EXECUTE FUNCTION admin.generate_partner_id();


--
-- Name: currency before_insert_currency; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_currency BEFORE INSERT ON admin.currency FOR EACH ROW EXECUTE FUNCTION admin.generate_currency_id();


--
-- Name: item_master_data before_insert_item_master_data; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_item_master_data BEFORE INSERT ON admin.item_master_data FOR EACH ROW EXECUTE FUNCTION admin.generate_item_id();


--
-- Name: notifications before_insert_notifications; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_notifications BEFORE INSERT ON admin.notifications FOR EACH ROW EXECUTE FUNCTION admin.notifications_id();


--
-- Name: policies before_insert_policies; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_policies BEFORE INSERT ON admin.policies FOR EACH ROW EXECUTE FUNCTION admin.generate_policy_id();


--
-- Name: products before_insert_products; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_products BEFORE INSERT ON admin.products FOR EACH ROW EXECUTE FUNCTION admin.generate_product_id();


--
-- Name: raw_materials before_insert_raw_materials; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_raw_materials BEFORE INSERT ON admin.raw_materials FOR EACH ROW EXECUTE FUNCTION admin.generate_material_id();


--
-- Name: roles_permission before_insert_role_permission; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_role_permission BEFORE INSERT ON admin.roles_permission FOR EACH ROW EXECUTE FUNCTION admin.generate_role_id();


--
-- Name: users before_insert_user; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_user BEFORE INSERT ON admin.users FOR EACH ROW EXECUTE FUNCTION admin.generate_user_id();


--
-- Name: vendor before_insert_vendor; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_vendor BEFORE INSERT ON admin.vendor FOR EACH ROW EXECUTE FUNCTION admin.generate_vendor_code();


--
-- Name: warehouse before_insert_warehouse; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER before_insert_warehouse BEFORE INSERT ON admin.warehouse FOR EACH ROW EXECUTE FUNCTION admin.generate_warehouse_id();


--
-- Name: products trg_auto_set_policy_id; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trg_auto_set_policy_id BEFORE INSERT ON admin.products FOR EACH ROW EXECUTE FUNCTION admin.auto_set_policy_id();


--
-- Name: users trg_hash_user_passwords; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trg_hash_user_passwords BEFORE INSERT ON admin.users FOR EACH ROW EXECUTE FUNCTION admin.before_insert_users();


--
-- Name: vendor trg_sync_bpm_vendor; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trg_sync_bpm_vendor AFTER INSERT OR UPDATE ON admin.vendor FOR EACH ROW EXECUTE FUNCTION admin.sync_bpm_vendor();


--
-- Name: assets trg_sync_item_master_data_assets; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trg_sync_item_master_data_assets AFTER INSERT ON admin.assets FOR EACH ROW EXECUTE FUNCTION admin.sync_item_master_data();


--
-- Name: products trg_sync_item_master_data_products; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trg_sync_item_master_data_products AFTER INSERT ON admin.products FOR EACH ROW EXECUTE FUNCTION admin.sync_item_master_data();


--
-- Name: raw_materials trg_sync_item_master_data_raw_materials; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trg_sync_item_master_data_raw_materials AFTER INSERT ON admin.raw_materials FOR EACH ROW EXECUTE FUNCTION admin.sync_item_master_data();


--
-- Name: audit_log trg_track_user; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trg_track_user BEFORE INSERT ON admin.audit_log FOR EACH ROW EXECUTE FUNCTION admin.track_user_activity();


--
-- Name: products trigger_create_product_pricing; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trigger_create_product_pricing AFTER INSERT ON admin.products FOR EACH ROW EXECUTE FUNCTION public.create_product_pricing();


--
-- Name: vendor trigger_sync_carrier_to_gl; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trigger_sync_carrier_to_gl AFTER INSERT ON admin.vendor FOR EACH ROW EXECUTE FUNCTION accounting.sync_carrier_to_gl_accounts();


--
-- Name: vendor trigger_sync_vendor_to_gl; Type: TRIGGER; Schema: admin; Owner: postgres
--

CREATE TRIGGER trigger_sync_vendor_to_gl AFTER INSERT ON admin.vendor FOR EACH ROW EXECUTE FUNCTION accounting.sync_vendor_to_gl_accounts();


--
-- Name: billing_receipt audit_generic_billing_receipt; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_billing_receipt AFTER INSERT OR DELETE OR UPDATE ON distribution.billing_receipt FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: carrier audit_generic_carrier; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_carrier AFTER INSERT OR DELETE OR UPDATE ON distribution.carrier FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: delivery_order audit_generic_delivery_order; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_delivery_order AFTER INSERT OR DELETE OR UPDATE ON distribution.delivery_order FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: delivery_receipt audit_generic_delivery_receipt; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_delivery_receipt AFTER INSERT OR DELETE OR UPDATE ON distribution.delivery_receipt FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: failed_shipment audit_generic_failed_shipment; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_failed_shipment AFTER INSERT OR DELETE OR UPDATE ON distribution.failed_shipment FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: goods_issue audit_generic_goods_issue; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_goods_issue AFTER INSERT OR DELETE OR UPDATE ON distribution.goods_issue FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: logistics_approval_request audit_generic_logistics_approval_request; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_logistics_approval_request AFTER INSERT OR DELETE OR UPDATE ON distribution.logistics_approval_request FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: operational_cost audit_generic_operational_cost; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_operational_cost AFTER INSERT OR DELETE OR UPDATE ON distribution.operational_cost FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: packing_cost audit_generic_packing_cost; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_packing_cost AFTER INSERT OR DELETE OR UPDATE ON distribution.packing_cost FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: packing_list audit_generic_packing_list; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_packing_list AFTER INSERT OR DELETE OR UPDATE ON distribution.packing_list FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: picking_list audit_generic_picking_list; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_picking_list AFTER INSERT OR DELETE OR UPDATE ON distribution.picking_list FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: rejection audit_generic_rejection; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_rejection AFTER INSERT OR DELETE OR UPDATE ON distribution.rejection FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: rework_order audit_generic_rework_order; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_rework_order AFTER INSERT OR DELETE OR UPDATE ON distribution.rework_order FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: shipment_details audit_generic_shipment_details; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_shipment_details AFTER INSERT OR DELETE OR UPDATE ON distribution.shipment_details FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: shipping_cost audit_generic_shipping_cost; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER audit_generic_shipping_cost AFTER INSERT OR DELETE OR UPDATE ON distribution.shipping_cost FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: billing_receipt before_insert_billing_receipt; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_billing_receipt BEFORE INSERT ON distribution.billing_receipt FOR EACH ROW EXECUTE FUNCTION distribution.generate_billing_receipt_id();


--
-- Name: carrier before_insert_carrier; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_carrier BEFORE INSERT ON distribution.carrier FOR EACH ROW EXECUTE FUNCTION distribution.generate_carrier_id();


--
-- Name: delivery_order before_insert_delivery_order; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_delivery_order BEFORE INSERT ON distribution.delivery_order FOR EACH ROW EXECUTE FUNCTION distribution.generate_del_order_id();


--
-- Name: delivery_receipt before_insert_delivery_receipt; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_delivery_receipt BEFORE INSERT ON distribution.delivery_receipt FOR EACH ROW EXECUTE FUNCTION distribution.generate_delivery_receipt_id();


--
-- Name: failed_shipment before_insert_failed_shipment; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_failed_shipment BEFORE INSERT ON distribution.failed_shipment FOR EACH ROW EXECUTE FUNCTION distribution.generate_failed_shipment_id();


--
-- Name: goods_issue before_insert_goods_issue; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_goods_issue BEFORE INSERT ON distribution.goods_issue FOR EACH ROW EXECUTE FUNCTION distribution.generate_goods_issue_id();


--
-- Name: logistics_approval_request before_insert_logistics_approval_request; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_logistics_approval_request BEFORE INSERT ON distribution.logistics_approval_request FOR EACH ROW EXECUTE FUNCTION distribution.generate_approval_request_id();


--
-- Name: operational_cost before_insert_operational_cost; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_operational_cost BEFORE INSERT ON distribution.operational_cost FOR EACH ROW EXECUTE FUNCTION distribution.generate_operational_cost_id();


--
-- Name: packing_cost before_insert_packing_cost; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_packing_cost BEFORE INSERT ON distribution.packing_cost FOR EACH ROW EXECUTE FUNCTION distribution.generate_packing_cost_id();


--
-- Name: packing_list before_insert_packing_list; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_packing_list BEFORE INSERT ON distribution.packing_list FOR EACH ROW EXECUTE FUNCTION distribution.generate_packing_list_id();


--
-- Name: picking_list before_insert_picking_list; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_picking_list BEFORE INSERT ON distribution.picking_list FOR EACH ROW EXECUTE FUNCTION distribution.generate_picking_list_id();


--
-- Name: rejection before_insert_rejection; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_rejection BEFORE INSERT ON distribution.rejection FOR EACH ROW EXECUTE FUNCTION distribution.generate_rejection_id();


--
-- Name: rework_order before_insert_rework_order; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_rework_order BEFORE INSERT ON distribution.rework_order FOR EACH ROW EXECUTE FUNCTION distribution.generate_rework_id();


--
-- Name: shipment_details before_insert_shipment_details; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_shipment_details BEFORE INSERT ON distribution.shipment_details FOR EACH ROW EXECUTE FUNCTION distribution.generate_shipment_details_id();


--
-- Name: shipping_cost before_insert_shipping_cost; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER before_insert_shipping_cost BEFORE INSERT ON distribution.shipping_cost FOR EACH ROW EXECUTE FUNCTION distribution.generate_shipping_cost_id();


--
-- Name: shipment_details shipment_status_update; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER shipment_status_update AFTER UPDATE OF shipment_status ON distribution.shipment_details FOR EACH ROW WHEN ((old.shipment_status IS DISTINCT FROM new.shipment_status)) EXECUTE FUNCTION sales.update_delivery_status();


--
-- Name: shipment_details trigger_create_journal_entry_on_shipping_completion; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER trigger_create_journal_entry_on_shipping_completion AFTER UPDATE ON distribution.shipment_details FOR EACH ROW WHEN (((old.shipment_status IS DISTINCT FROM 'Delivered'::public.shipment_status_type) AND (new.shipment_status = 'Delivered'::public.shipment_status_type))) EXECUTE FUNCTION accounting.create_journal_entry_for_shipping_cost();


--
-- Name: goods_issue trigger_goods_issue_journal; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER trigger_goods_issue_journal AFTER INSERT ON distribution.goods_issue FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_distribution_goods_issue();


--
-- Name: shipment_details trigger_shipping_cost_journal; Type: TRIGGER; Schema: distribution; Owner: postgres
--

CREATE TRIGGER trigger_shipping_cost_journal AFTER INSERT ON distribution.shipment_details FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_shipping_cost();


--
-- Name: budget_allocation audit_generic_budget_allocation; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER audit_generic_budget_allocation AFTER INSERT OR DELETE OR UPDATE ON finance.budget_allocation FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: budget_approvals audit_generic_budget_approvals; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER audit_generic_budget_approvals AFTER INSERT OR DELETE OR UPDATE ON finance.budget_approvals FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: budget_request_form audit_generic_budget_request_form; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER audit_generic_budget_request_form AFTER INSERT OR DELETE OR UPDATE ON finance.budget_request_form FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: budget_returns_form audit_generic_budget_returns_form; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER audit_generic_budget_returns_form AFTER INSERT OR DELETE OR UPDATE ON finance.budget_returns_form FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: budget_submission audit_generic_budget_submission; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER audit_generic_budget_submission AFTER INSERT OR DELETE OR UPDATE ON finance.budget_submission FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: budget_validations audit_generic_budget_validations; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER audit_generic_budget_validations AFTER INSERT OR DELETE OR UPDATE ON finance.budget_validations FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: budget_allocation before_insert_budget_allocation; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER before_insert_budget_allocation BEFORE INSERT ON finance.budget_allocation FOR EACH ROW EXECUTE FUNCTION finance.generate_budget_allocation_id();


--
-- Name: budget_approvals before_insert_budget_approvals; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER before_insert_budget_approvals BEFORE INSERT ON finance.budget_approvals FOR EACH ROW EXECUTE FUNCTION finance.generate_budget_approvals_id();


--
-- Name: budget_request_form before_insert_budget_request_form; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER before_insert_budget_request_form BEFORE INSERT ON finance.budget_request_form FOR EACH ROW EXECUTE FUNCTION finance.generate_budget_request_id();


--
-- Name: budget_returns_form before_insert_budget_returns_form; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER before_insert_budget_returns_form BEFORE INSERT ON finance.budget_returns_form FOR EACH ROW EXECUTE FUNCTION finance.generate_budget_return_id();


--
-- Name: budget_submission before_insert_budget_submission; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER before_insert_budget_submission BEFORE INSERT ON finance.budget_submission FOR EACH ROW EXECUTE FUNCTION finance.generate_budget_submission_id();


--
-- Name: budget_validations before_insert_budget_validations; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER before_insert_budget_validations BEFORE INSERT ON finance.budget_validations FOR EACH ROW EXECUTE FUNCTION finance.generate_validation_id();


--
-- Name: budget_allocation trg_create_journal_entry_budget_allocation; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER trg_create_journal_entry_budget_allocation AFTER INSERT OR UPDATE ON finance.budget_allocation FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_budget_allocation();


--
-- Name: budget_returns_form trg_create_journal_entry_budget_return; Type: TRIGGER; Schema: finance; Owner: postgres
--

CREATE TRIGGER trg_create_journal_entry_budget_return AFTER INSERT ON finance.budget_returns_form FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_budget_return();


--
-- Name: attendance_tracking audit_generic_attendance_tracking; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_attendance_tracking AFTER INSERT OR DELETE OR UPDATE ON human_resources.attendance_tracking FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: calendar_dates audit_generic_calendar_dates; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_calendar_dates AFTER INSERT OR DELETE OR UPDATE ON human_resources.calendar_dates FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: candidates audit_generic_candidates; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_candidates AFTER INSERT OR DELETE OR UPDATE ON human_resources.candidates FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: department_superiors audit_generic_department_superiors; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_department_superiors AFTER INSERT OR DELETE OR UPDATE ON human_resources.department_superiors FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: departments audit_generic_departments; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_departments AFTER INSERT OR DELETE OR UPDATE ON human_resources.departments FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: employee_leave_balances audit_generic_employee_leave_balances; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_employee_leave_balances AFTER INSERT OR DELETE OR UPDATE ON human_resources.employee_leave_balances FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: employee_performance audit_generic_employee_performance; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_employee_performance AFTER INSERT OR DELETE OR UPDATE ON human_resources.employee_performance FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: employee_salary audit_generic_employee_salary; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_employee_salary AFTER INSERT OR DELETE OR UPDATE ON human_resources.employee_salary FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: employees audit_generic_employees; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_employees AFTER INSERT OR DELETE OR UPDATE ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: job_posting audit_generic_job_posting; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_job_posting AFTER INSERT OR DELETE OR UPDATE ON human_resources.job_posting FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: leave_requests audit_generic_leave_requests; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_leave_requests AFTER INSERT OR DELETE OR UPDATE ON human_resources.leave_requests FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: payroll audit_generic_payroll; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_payroll AFTER INSERT OR DELETE OR UPDATE ON human_resources.payroll FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: positions audit_generic_positions; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_positions AFTER INSERT OR DELETE OR UPDATE ON human_resources.positions FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: resignations audit_generic_resignations; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_resignations AFTER INSERT OR DELETE OR UPDATE ON human_resources.resignations FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: workforce_allocation audit_generic_workforce_allocation; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER audit_generic_workforce_allocation AFTER INSERT OR DELETE OR UPDATE ON human_resources.workforce_allocation FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: attendance_tracking before_insert_attendance; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER before_insert_attendance BEFORE INSERT ON human_resources.attendance_tracking FOR EACH ROW WHEN ((new.attendance_id IS NULL)) EXECUTE FUNCTION human_resources.generate_attendance_id();


--
-- Name: departments before_insert_department; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER before_insert_department BEFORE INSERT ON human_resources.departments FOR EACH ROW EXECUTE FUNCTION human_resources.generate_department_id();


--
-- Name: employees before_insert_employee; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER before_insert_employee BEFORE INSERT ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION human_resources.generate_employee_id();


--
-- Name: workforce_allocation trg_allocation_id; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_allocation_id BEFORE INSERT ON human_resources.workforce_allocation FOR EACH ROW EXECUTE FUNCTION human_resources.generate_allocation_id();


--
-- Name: employee_performance trg_calculate_performance_bonus; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_calculate_performance_bonus BEFORE INSERT OR UPDATE ON human_resources.employee_performance FOR EACH ROW EXECUTE FUNCTION human_resources.calculate_performance_bonus();


--
-- Name: attendance_tracking trg_calculate_work_hours; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_calculate_work_hours BEFORE INSERT OR UPDATE ON human_resources.attendance_tracking FOR EACH ROW EXECUTE FUNCTION human_resources.calculate_work_hours();


--
-- Name: workforce_allocation trg_check_assignment_overlap; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_check_assignment_overlap BEFORE INSERT OR UPDATE ON human_resources.workforce_allocation FOR EACH ROW EXECUTE FUNCTION public.check_assignment_overlap();


--
-- Name: leave_requests trg_deduct_leave_balances; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_deduct_leave_balances AFTER UPDATE ON human_resources.leave_requests FOR EACH ROW EXECUTE FUNCTION human_resources.deduct_leave_balances();


--
-- Name: job_posting trg_generate_job_id; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_generate_job_id BEFORE INSERT ON human_resources.job_posting FOR EACH ROW EXECUTE FUNCTION human_resources.generate_job_id();


--
-- Name: employee_leave_balances trg_generate_leave_balance_id; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_generate_leave_balance_id BEFORE INSERT ON human_resources.employee_leave_balances FOR EACH ROW EXECUTE FUNCTION human_resources.generate_leave_balance_id();


--
-- Name: payroll trg_generate_payroll; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_generate_payroll BEFORE INSERT ON human_resources.payroll FOR EACH ROW EXECUTE FUNCTION human_resources.generate_bi_monthly_payroll();


--
-- Name: positions trg_generate_position_id; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_generate_position_id BEFORE INSERT ON human_resources.positions FOR EACH ROW WHEN ((new.position_id IS NULL)) EXECUTE FUNCTION human_resources.generate_position_id();


--
-- Name: resignations trg_generate_resignation_id; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_generate_resignation_id BEFORE INSERT ON human_resources.resignations FOR EACH ROW WHEN ((new.resignation_id IS NULL)) EXECUTE FUNCTION human_resources.generate_resignation_id();


--
-- Name: leave_requests trg_handle_leave_approval; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_handle_leave_approval BEFORE UPDATE ON human_resources.leave_requests FOR EACH ROW EXECUTE FUNCTION human_resources.handle_leave_approval();


--
-- Name: leave_requests trg_process_leave_request; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_process_leave_request BEFORE INSERT ON human_resources.leave_requests FOR EACH ROW EXECUTE FUNCTION human_resources.process_leave_request();


--
-- Name: resignations trg_process_resignation; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_process_resignation BEFORE INSERT ON human_resources.resignations FOR EACH ROW EXECUTE FUNCTION human_resources.process_resignation();


--
-- Name: job_posting trg_set_compensation; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_set_compensation BEFORE INSERT OR UPDATE ON human_resources.job_posting FOR EACH ROW EXECUTE FUNCTION human_resources.set_compensation_values();


--
-- Name: positions trg_set_position_defaults; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_set_position_defaults BEFORE INSERT OR UPDATE ON human_resources.positions FOR EACH ROW EXECUTE FUNCTION human_resources.set_position_defaults();


--
-- Name: employees trg_set_supervisor_flag; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_set_supervisor_flag BEFORE INSERT OR UPDATE ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION human_resources.set_supervisor_flag();


--
-- Name: employees trg_sync_bpm_employee; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_sync_bpm_employee AFTER INSERT OR UPDATE ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION human_resources.sync_bpm_employee();


--
-- Name: employees trg_sync_users_from_employees; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_sync_users_from_employees AFTER INSERT OR UPDATE ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION admin.sync_users_from_employees();


--
-- Name: workforce_allocation trg_track_status; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_track_status BEFORE UPDATE ON human_resources.workforce_allocation FOR EACH ROW EXECUTE FUNCTION human_resources.track_allocation_status();


--
-- Name: resignations trg_update_employee_resignation; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_employee_resignation AFTER UPDATE ON human_resources.resignations FOR EACH ROW EXECUTE FUNCTION human_resources.update_employee_resignation();


--
-- Name: employees trg_update_employee_timestamp; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_employee_timestamp BEFORE UPDATE ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION human_resources.update_employee_timestamp();


--
-- Name: leave_requests trg_update_leave_balances; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_leave_balances AFTER UPDATE ON human_resources.leave_requests FOR EACH ROW EXECUTE FUNCTION public.update_leave_balances();


--
-- Name: payroll trg_update_payroll_status; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_payroll_status BEFORE UPDATE ON human_resources.payroll FOR EACH ROW EXECUTE FUNCTION human_resources.update_payroll_status();


--
-- Name: positions trg_update_position_timestamp; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_position_timestamp BEFORE UPDATE ON human_resources.positions FOR EACH ROW EXECUTE FUNCTION human_resources.update_position_timestamp();


--
-- Name: candidates trg_update_timestamp_candidates; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamp_candidates BEFORE UPDATE ON human_resources.candidates FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: employees trg_update_timestamp_employees; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamp_employees BEFORE UPDATE ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: job_posting trg_update_timestamp_job_posting; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamp_job_posting BEFORE UPDATE ON human_resources.job_posting FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: leave_requests trg_update_timestamp_leave_requests; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamp_leave_requests BEFORE UPDATE ON human_resources.leave_requests FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: payroll trg_update_timestamp_payroll; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamp_payroll BEFORE UPDATE ON human_resources.payroll FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: positions trg_update_timestamp_positions; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamp_positions BEFORE UPDATE ON human_resources.positions FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: workforce_allocation trg_update_timestamp_workforce_allocation; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamp_workforce_allocation BEFORE UPDATE ON human_resources.workforce_allocation FOR EACH ROW EXECUTE FUNCTION public.update_timestamp();


--
-- Name: job_posting trg_update_timestamps; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_update_timestamps BEFORE UPDATE ON human_resources.job_posting FOR EACH ROW EXECUTE FUNCTION human_resources.update_job_timestamps();


--
-- Name: job_posting trg_validate_approval; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_validate_approval BEFORE INSERT OR UPDATE ON human_resources.job_posting FOR EACH ROW EXECUTE FUNCTION human_resources.validate_finance_approval();


--
-- Name: leave_requests trg_validate_leave_request; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_validate_leave_request BEFORE INSERT ON human_resources.leave_requests FOR EACH ROW EXECUTE FUNCTION human_resources.validate_leave_request();


--
-- Name: employee_salary trg_validate_salary; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_validate_salary BEFORE INSERT OR UPDATE ON human_resources.employee_salary FOR EACH ROW EXECUTE FUNCTION human_resources.validate_salary();


--
-- Name: employees trg_validate_superior; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trg_validate_superior BEFORE INSERT OR UPDATE ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION human_resources.validate_superior();


--
-- Name: payroll trigger_create_journal_entry_on_payroll_completion; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trigger_create_journal_entry_on_payroll_completion AFTER UPDATE ON human_resources.payroll FOR EACH ROW WHEN ((((old.status)::text IS DISTINCT FROM 'Paid'::text) AND ((new.status)::text = 'Paid'::text))) EXECUTE FUNCTION accounting.create_journal_entry_for_payroll();


--
-- Name: payroll trigger_payroll_journal; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trigger_payroll_journal AFTER INSERT ON human_resources.payroll FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_payroll();


--
-- Name: employees trigger_sync_employee_to_gl; Type: TRIGGER; Schema: human_resources; Owner: postgres
--

CREATE TRIGGER trigger_sync_employee_to_gl AFTER INSERT ON human_resources.employees FOR EACH ROW EXECUTE FUNCTION accounting.sync_employee_to_gl_accounts();


--
-- Name: deprecation_report audit_generic_deprecation_report; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER audit_generic_deprecation_report AFTER INSERT OR DELETE OR UPDATE ON inventory.deprecation_report FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: inventory_adjustments audit_generic_inventory_adjustments; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER audit_generic_inventory_adjustments AFTER INSERT OR DELETE OR UPDATE ON inventory.inventory_adjustments FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: inventory_cyclic_counts audit_generic_inventory_cyclic_counts; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER audit_generic_inventory_cyclic_counts AFTER INSERT OR DELETE OR UPDATE ON inventory.inventory_cyclic_counts FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: inventory_item audit_generic_inventory_item; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER audit_generic_inventory_item AFTER INSERT OR DELETE OR UPDATE ON inventory.inventory_item FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: warehouse_movement audit_generic_warehouse_movement; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER audit_generic_warehouse_movement AFTER INSERT OR DELETE OR UPDATE ON inventory.warehouse_movement FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: deprecation_report before_insert_deprecation_report; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER before_insert_deprecation_report BEFORE INSERT ON inventory.deprecation_report FOR EACH ROW EXECUTE FUNCTION inventory.generate_deprecation_report_id();


--
-- Name: expiry_report before_insert_expiry_report; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER before_insert_expiry_report BEFORE INSERT ON inventory.expiry_report FOR EACH ROW EXECUTE FUNCTION inventory.generate_expiry_report_id();


--
-- Name: inventory_adjustments before_insert_inventory_adjustments; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER before_insert_inventory_adjustments BEFORE INSERT ON inventory.inventory_adjustments FOR EACH ROW EXECUTE FUNCTION inventory.generate_adjustment_id();


--
-- Name: inventory_cyclic_counts before_insert_inventory_cyclic_counts; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER before_insert_inventory_cyclic_counts BEFORE INSERT ON inventory.inventory_cyclic_counts FOR EACH ROW EXECUTE FUNCTION inventory.generate_inventory_count_id();


--
-- Name: inventory_item before_insert_inventory_item; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER before_insert_inventory_item BEFORE INSERT ON inventory.inventory_item FOR EACH ROW EXECUTE FUNCTION inventory.generate_inventory_item_id();


--
-- Name: inventory_item_threshold before_insert_inventory_item_threshold_id; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER before_insert_inventory_item_threshold_id BEFORE INSERT ON inventory.inventory_item_threshold FOR EACH ROW EXECUTE FUNCTION inventory.inventory_item_threshold_id();


--
-- Name: warehouse_movement before_insert_warehouse_movement; Type: TRIGGER; Schema: inventory; Owner: postgres
--

CREATE TRIGGER before_insert_warehouse_movement BEFORE INSERT ON inventory.warehouse_movement FOR EACH ROW EXECUTE FUNCTION inventory.generate_movement_id();


--
-- Name: management_approvals audit_generic_management_approvals; Type: TRIGGER; Schema: management; Owner: postgres
--

CREATE TRIGGER audit_generic_management_approvals AFTER INSERT OR DELETE OR UPDATE ON management.management_approvals FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: management_approvals before_insert_management_approvals; Type: TRIGGER; Schema: management; Owner: postgres
--

CREATE TRIGGER before_insert_management_approvals BEFORE INSERT ON management.management_approvals FOR EACH ROW EXECUTE FUNCTION management.generate_approval_id();


--
-- Name: bill_of_materials audit_generic_bill_of_materials; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER audit_generic_bill_of_materials AFTER INSERT OR DELETE OR UPDATE ON mrp.bill_of_materials FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: labor_cost audit_generic_labor_cost; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER audit_generic_labor_cost AFTER INSERT OR DELETE OR UPDATE ON mrp.labor_cost FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: non_project_order_pricing audit_generic_non_project_order_pricing; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER audit_generic_non_project_order_pricing AFTER INSERT OR DELETE OR UPDATE ON mrp.non_project_order_pricing FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: principal_items audit_generic_principal_items; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER audit_generic_principal_items AFTER INSERT OR DELETE OR UPDATE ON mrp.principal_items FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: product_mats audit_generic_product_mats; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER audit_generic_product_mats AFTER INSERT OR DELETE OR UPDATE ON mrp.product_mats FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: bill_of_materials before_insert_bom; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER before_insert_bom BEFORE INSERT ON mrp.bill_of_materials FOR EACH ROW EXECUTE FUNCTION mrp.generate_bom_id();


--
-- Name: labor_cost before_insert_labor_cost; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER before_insert_labor_cost BEFORE INSERT ON mrp.labor_cost FOR EACH ROW EXECUTE FUNCTION mrp.generate_labor_cost_id();


--
-- Name: non_project_order_pricing before_insert_non_project_costing; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER before_insert_non_project_costing BEFORE INSERT ON mrp.non_project_order_pricing FOR EACH ROW EXECUTE FUNCTION mrp.generate_non_project_costing_id();


--
-- Name: principal_items before_insert_principal_item; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER before_insert_principal_item BEFORE INSERT ON mrp.principal_items FOR EACH ROW EXECUTE FUNCTION mrp.generate_principal_item_id();


--
-- Name: product_mats before_insert_product_material; Type: TRIGGER; Schema: mrp; Owner: postgres
--

CREATE TRIGGER before_insert_product_material BEFORE INSERT ON mrp.product_mats FOR EACH ROW EXECUTE FUNCTION mrp.generate_product_material_id();


--
-- Name: document_items audit_generic_documen_items; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER audit_generic_documen_items AFTER INSERT OR DELETE OR UPDATE ON operations.document_items FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: document_header audit_generic_document_header; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER audit_generic_document_header AFTER INSERT OR DELETE OR UPDATE ON operations.document_header FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_module audit_generic_external_module; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER audit_generic_external_module AFTER INSERT OR DELETE OR UPDATE ON operations.external_module FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: product_document_items audit_generic_product_document_items; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER audit_generic_product_document_items AFTER INSERT OR DELETE OR UPDATE ON operations.product_document_items FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: serial_tracking audit_generic_serial_tracking; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER audit_generic_serial_tracking AFTER INSERT OR DELETE OR UPDATE ON operations.serial_tracking FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: document_header before_insert_document_header; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER before_insert_document_header BEFORE INSERT ON operations.document_header FOR EACH ROW EXECUTE FUNCTION operations.generate_document_id();


--
-- Name: document_items before_insert_document_items; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER before_insert_document_items BEFORE INSERT ON operations.document_items FOR EACH ROW EXECUTE FUNCTION operations.generate_content_id();


--
-- Name: external_module before_insert_external_module; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER before_insert_external_module BEFORE INSERT ON operations.external_module FOR EACH ROW EXECUTE FUNCTION operations.generate_external_id();


--
-- Name: product_document_items before_insert_product_document_items; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER before_insert_product_document_items BEFORE INSERT ON operations.product_document_items FOR EACH ROW EXECUTE FUNCTION operations.generate_productdocu_id();


--
-- Name: serial_tracking before_insert_serial_tracking; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER before_insert_serial_tracking BEFORE INSERT ON operations.serial_tracking FOR EACH ROW EXECUTE FUNCTION operations.generate_serial_id();


--
-- Name: document_header trg_generate_ar_credit_memo_id; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trg_generate_ar_credit_memo_id BEFORE INSERT ON operations.document_header FOR EACH ROW WHEN ((new.ar_credit_memo IS NULL)) EXECUTE FUNCTION operations.generate_ar_credit_memo_id();


--
-- Name: serial_tracking trg_generate_asset_serial; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trg_generate_asset_serial BEFORE INSERT ON operations.serial_tracking FOR EACH ROW WHEN ((new.serial_no IS NULL)) EXECUTE FUNCTION operations.generate_asset_serial();


--
-- Name: document_items trg_generate_batch_number; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trg_generate_batch_number BEFORE INSERT ON operations.document_items FOR EACH ROW WHEN ((new.batch_no IS NULL)) EXECUTE FUNCTION operations.generate_batch_number();


--
-- Name: document_header trigger_ar_credit_memo_journal; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trigger_ar_credit_memo_journal AFTER INSERT ON operations.document_header FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_ar_credit_memo();


--
-- Name: external_module trigger_external_module_update; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trigger_external_module_update AFTER UPDATE ON operations.external_module FOR EACH ROW WHEN (((old.external_id)::text IS DISTINCT FROM (new.external_id)::text)) EXECUTE FUNCTION operations.handle_external_module_update();


--
-- Name: document_items trigger_goods_issue_journal; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trigger_goods_issue_journal AFTER INSERT ON operations.document_items FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_goods_issue();


--
-- Name: document_items trigger_goods_receipt_journal; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trigger_goods_receipt_journal AFTER INSERT ON operations.document_items FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_goods_receipt();


--
-- Name: document_items trigger_grpo_journal; Type: TRIGGER; Schema: operations; Owner: postgres
--

CREATE TRIGGER trigger_grpo_journal AFTER INSERT ON operations.document_items FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_grpo();


--
-- Name: equipment audit_generic_equipment; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER audit_generic_equipment AFTER INSERT OR DELETE OR UPDATE ON production.equipment FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: labor audit_generic_labor; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER audit_generic_labor AFTER INSERT OR DELETE OR UPDATE ON production.labor FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: production_orders_details audit_generic_production_orders_details; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER audit_generic_production_orders_details AFTER INSERT OR DELETE OR UPDATE ON production.production_orders_details FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: production_orders_header audit_generic_production_orders_header; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER audit_generic_production_orders_header AFTER INSERT OR DELETE OR UPDATE ON production.production_orders_header FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: project_equipment audit_generic_project_equipment; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER audit_generic_project_equipment AFTER INSERT OR DELETE OR UPDATE ON production.project_equipment FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: rework_cost audit_generic_rework_cost; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER audit_generic_rework_cost AFTER INSERT OR DELETE OR UPDATE ON production.rework_cost FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: equipment before_insert_equipment; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER before_insert_equipment BEFORE INSERT ON production.equipment FOR EACH ROW EXECUTE FUNCTION production.generate_equipment_id();


--
-- Name: labor before_insert_labor; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER before_insert_labor BEFORE INSERT ON production.labor FOR EACH ROW EXECUTE FUNCTION production.generate_labor_id();


--
-- Name: production_orders_header before_insert_production_order; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER before_insert_production_order BEFORE INSERT ON production.production_orders_header FOR EACH ROW EXECUTE FUNCTION production.generate_production_order_id();


--
-- Name: production_orders_details before_insert_production_order_detail; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER before_insert_production_order_detail BEFORE INSERT ON production.production_orders_details FOR EACH ROW EXECUTE FUNCTION production.generate_production_order_detail_id();


--
-- Name: project_equipment before_insert_project_equipment; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER before_insert_project_equipment BEFORE INSERT ON production.project_equipment FOR EACH ROW EXECUTE FUNCTION production.generate_project_equipment_id();


--
-- Name: rework_cost trigger_generate_rework_cost_id; Type: TRIGGER; Schema: production; Owner: postgres
--

CREATE TRIGGER trigger_generate_rework_cost_id BEFORE INSERT ON production.rework_cost FOR EACH ROW EXECUTE FUNCTION production.generate_rework_cost_id();


--
-- Name: external_project_cost_management audit_generic_external_project_cost_management; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_cost_management AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_cost_management FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_details audit_generic_external_project_details; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_details AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_details FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_equipments audit_generic_external_project_equipments; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_equipments AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_equipments FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_labor audit_generic_external_project_labor; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_labor AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_labor FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_request audit_generic_external_project_request; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_request AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_request FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_task_list audit_generic_external_project_task_list; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_task_list AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_task_list FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_tracking audit_generic_external_project_tracking; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_tracking AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_tracking FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_warranty audit_generic_external_project_warranty; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_external_project_warranty AFTER INSERT OR DELETE OR UPDATE ON project_management.external_project_warranty FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: internal_project_cost_management audit_generic_internal_project_cost_management; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_internal_project_cost_management AFTER INSERT OR DELETE OR UPDATE ON project_management.internal_project_cost_management FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: internal_project_details audit_generic_internal_project_details; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_internal_project_details AFTER INSERT OR DELETE OR UPDATE ON project_management.internal_project_details FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: internal_project_labor audit_generic_internal_project_labor; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_internal_project_labor AFTER INSERT OR DELETE OR UPDATE ON project_management.internal_project_labor FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: internal_project_request audit_generic_internal_project_request; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_internal_project_request AFTER INSERT OR DELETE OR UPDATE ON project_management.internal_project_request FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: internal_project_task_list audit_generic_internal_project_task_list; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_internal_project_task_list AFTER INSERT OR DELETE OR UPDATE ON project_management.internal_project_task_list FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: internal_project_tracking audit_generic_internal_project_tracking; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_internal_project_tracking AFTER INSERT OR DELETE OR UPDATE ON project_management.internal_project_tracking FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: report_monitoring audit_generic_report_monitoring; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER audit_generic_report_monitoring AFTER INSERT OR DELETE OR UPDATE ON project_management.report_monitoring FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: external_project_cost_management before_insert_external_project_cost_management; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_cost_management BEFORE INSERT ON project_management.external_project_cost_management FOR EACH ROW EXECUTE FUNCTION public.generate_external_project_resources_id();


--
-- Name: external_project_details before_insert_external_project_details; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_details BEFORE INSERT ON project_management.external_project_details FOR EACH ROW EXECUTE FUNCTION public.generate_external_project_details_id();


--
-- Name: external_project_equipments before_insert_external_project_equipments; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_equipments BEFORE INSERT ON project_management.external_project_equipments FOR EACH ROW EXECUTE FUNCTION public.generate_project_equipment_list_id();


--
-- Name: external_project_labor before_insert_external_project_labor; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_labor BEFORE INSERT ON project_management.external_project_labor FOR EACH ROW EXECUTE FUNCTION public.generate_external_project_labor_id();


--
-- Name: external_project_request before_insert_external_project_request; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_request BEFORE INSERT ON project_management.external_project_request FOR EACH ROW EXECUTE FUNCTION public.generate_external_project_request_id();


--
-- Name: external_project_task_list before_insert_external_project_task; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_task BEFORE INSERT ON project_management.external_project_task_list FOR EACH ROW EXECUTE FUNCTION public.generate_external_project_task_id();


--
-- Name: external_project_tracking before_insert_external_project_tracking; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_tracking BEFORE INSERT ON project_management.external_project_tracking FOR EACH ROW EXECUTE FUNCTION public.generate_external_project_tracking_id();


--
-- Name: external_project_warranty before_insert_external_project_warranty; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_external_project_warranty BEFORE INSERT ON project_management.external_project_warranty FOR EACH ROW EXECUTE FUNCTION public.generate_external_project_warranty_id();


--
-- Name: internal_project_cost_management before_insert_internal_project_cost_management; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_internal_project_cost_management BEFORE INSERT ON project_management.internal_project_cost_management FOR EACH ROW EXECUTE FUNCTION public.generate_intrnl_project_resources_id();


--
-- Name: internal_project_details before_insert_internal_project_details; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_internal_project_details BEFORE INSERT ON project_management.internal_project_details FOR EACH ROW EXECUTE FUNCTION public.generate_internal_project_details_id();


--
-- Name: internal_project_labor before_insert_internal_project_labor; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_internal_project_labor BEFORE INSERT ON project_management.internal_project_labor FOR EACH ROW EXECUTE FUNCTION public.generate_internal_project_labor_id();


--
-- Name: internal_project_request before_insert_internal_project_request; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_internal_project_request BEFORE INSERT ON project_management.internal_project_request FOR EACH ROW EXECUTE FUNCTION public.generate_internal_project_request_id();


--
-- Name: internal_project_task_list before_insert_internal_project_task; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_internal_project_task BEFORE INSERT ON project_management.internal_project_task_list FOR EACH ROW EXECUTE FUNCTION public.generate_internal_project_task_id();


--
-- Name: internal_project_tracking before_insert_internal_project_tracking; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_internal_project_tracking BEFORE INSERT ON project_management.internal_project_tracking FOR EACH ROW EXECUTE FUNCTION public.generate_internal_project_tracking_id();


--
-- Name: report_monitoring before_insert_report_monitoring; Type: TRIGGER; Schema: project_management; Owner: postgres
--

CREATE TRIGGER before_insert_report_monitoring BEFORE INSERT ON project_management.report_monitoring FOR EACH ROW EXECUTE FUNCTION public.generate_report_monitoring_id();


--
-- Name: batch_inspection audit_generic_batch_inspection; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_batch_inspection AFTER INSERT OR DELETE OR UPDATE ON purchasing.batch_inspection FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: credit_memo audit_generic_credit_memo; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_credit_memo AFTER INSERT OR DELETE OR UPDATE ON purchasing.credit_memo FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: purchase_invoice audit_generic_purchase_invoice; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_purchase_invoice AFTER INSERT OR DELETE OR UPDATE ON purchasing.purchase_invoice FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: purchase_order audit_generic_purchase_order; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_purchase_order AFTER INSERT OR DELETE OR UPDATE ON purchasing.purchase_order FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: purchase_quotation audit_generic_purchase_quotation; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_purchase_quotation AFTER INSERT OR DELETE OR UPDATE ON purchasing.purchase_quotation FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: purchase_requests audit_generic_purchase_requests; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_purchase_requests AFTER INSERT OR DELETE OR UPDATE ON purchasing.purchase_requests FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: quotation_contents audit_generic_quotation_contents; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_quotation_contents AFTER INSERT OR DELETE OR UPDATE ON purchasing.quotation_contents FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: received_shipments audit_generic_received_shipments; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_received_shipments AFTER INSERT OR DELETE OR UPDATE ON purchasing.received_shipments FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: vendor_application audit_generic_vendor_application; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER audit_generic_vendor_application AFTER INSERT OR DELETE OR UPDATE ON purchasing.vendor_application FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: batch_inspection before_insert_batch_inspection; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_batch_inspection BEFORE INSERT ON purchasing.batch_inspection FOR EACH ROW EXECUTE FUNCTION purchasing.generate_inspection_id();


--
-- Name: credit_memo before_insert_credit_memo; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_credit_memo BEFORE INSERT ON purchasing.credit_memo FOR EACH ROW EXECUTE FUNCTION purchasing.generate_credit_memo_id();


--
-- Name: purchase_invoice before_insert_purchase_invoice; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_purchase_invoice BEFORE INSERT ON purchasing.purchase_invoice FOR EACH ROW EXECUTE FUNCTION purchasing.generate_invoice_id();


--
-- Name: purchase_order before_insert_purchase_order; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_purchase_order BEFORE INSERT ON purchasing.purchase_order FOR EACH ROW EXECUTE FUNCTION purchasing.generate_purchase_id();


--
-- Name: purchase_quotation before_insert_purchase_quotation; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_purchase_quotation BEFORE INSERT ON purchasing.purchase_quotation FOR EACH ROW EXECUTE FUNCTION purchasing.generate_quotation_id();


--
-- Name: purchase_requests before_insert_purchase_requests; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_purchase_requests BEFORE INSERT ON purchasing.purchase_requests FOR EACH ROW EXECUTE FUNCTION purchasing.generate_request_id();


--
-- Name: quotation_contents before_insert_quotation_contents; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_quotation_contents BEFORE INSERT ON purchasing.quotation_contents FOR EACH ROW EXECUTE FUNCTION purchasing.generate_quotation_content_id();


--
-- Name: received_shipments before_insert_received_shipments; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_received_shipments BEFORE INSERT ON purchasing.received_shipments FOR EACH ROW EXECUTE FUNCTION purchasing.generate_shipment_id();


--
-- Name: vendor_application before_insert_vendor_application; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER before_insert_vendor_application BEFORE INSERT ON purchasing.vendor_application FOR EACH ROW EXECUTE FUNCTION purchasing.generate_application_reference();


--
-- Name: vendor_application trg_auto_insert_vendor_on_insert; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER trg_auto_insert_vendor_on_insert AFTER INSERT ON purchasing.vendor_application FOR EACH ROW EXECUTE FUNCTION purchasing.auto_insert_vendor();


--
-- Name: vendor_application trg_auto_insert_vendor_on_update; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER trg_auto_insert_vendor_on_update AFTER UPDATE ON purchasing.vendor_application FOR EACH ROW WHEN (((old.status IS DISTINCT FROM new.status) OR (old.status IS NULL))) EXECUTE FUNCTION purchasing.auto_insert_vendor();


--
-- Name: purchase_invoice trigger_create_journal_entry_on_invoice_completion; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER trigger_create_journal_entry_on_invoice_completion AFTER UPDATE ON purchasing.purchase_invoice FOR EACH ROW WHEN (((old.status IS DISTINCT FROM 'Completed'::public.purchase_status) AND (new.status = 'Completed'::public.purchase_status))) EXECUTE FUNCTION accounting.create_journal_entry_for_purchase_invoice();


--
-- Name: purchase_invoice trigger_purchase_invoice_journal; Type: TRIGGER; Schema: purchasing; Owner: postgres
--

CREATE TRIGGER trigger_purchase_invoice_journal AFTER INSERT ON purchasing.purchase_invoice FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_purchase_invoice();


--
-- Name: blanket_agreement audit_generic_blanket_agreement; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_blanket_agreement AFTER INSERT OR DELETE OR UPDATE ON sales.blanket_agreement FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: campaign_contacts audit_generic_campaign_contacts; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_campaign_contacts AFTER INSERT OR DELETE OR UPDATE ON sales.campaign_contacts FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: campaigns audit_generic_campaigns; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_campaigns AFTER INSERT OR DELETE OR UPDATE ON sales.campaigns FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: customers audit_generic_customers; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_customers AFTER INSERT OR DELETE OR UPDATE ON sales.customers FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: opportunities audit_generic_opportunities; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_opportunities AFTER INSERT OR DELETE OR UPDATE ON sales.opportunities FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: orders audit_generic_orders; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_orders AFTER INSERT OR DELETE OR UPDATE ON sales.orders FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: payments audit_generic_payments; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_payments AFTER INSERT OR DELETE OR UPDATE ON sales.payments FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: product_pricing audit_generic_product_pricing; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_product_pricing AFTER INSERT OR DELETE OR UPDATE ON sales.product_pricing FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: quotation audit_generic_quotation; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_quotation AFTER INSERT OR DELETE OR UPDATE ON sales.quotation FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: return audit_generic_return; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_return AFTER INSERT OR DELETE OR UPDATE ON sales.return FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: sales_invoices audit_generic_sales_invoices; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_sales_invoices AFTER INSERT OR DELETE OR UPDATE ON sales.sales_invoices FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: statement audit_generic_statement; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_statement AFTER INSERT OR DELETE OR UPDATE ON sales.statement FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: statement_item audit_generic_statement_item; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_statement_item AFTER INSERT OR DELETE OR UPDATE ON sales.statement_item FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: ticket audit_generic_ticket; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_ticket AFTER INSERT OR DELETE OR UPDATE ON sales.ticket FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: ticket_convo audit_generic_ticket_convo; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER audit_generic_ticket_convo AFTER INSERT OR DELETE OR UPDATE ON sales.ticket_convo FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: blanket_agreement before_insert_blanket_agreement; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_blanket_agreement BEFORE INSERT ON sales.blanket_agreement FOR EACH ROW EXECUTE FUNCTION sales.generate_agreement_id();


--
-- Name: campaigns before_insert_campaign; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_campaign BEFORE INSERT ON sales.campaigns FOR EACH ROW EXECUTE FUNCTION sales.generate_campaign_id();


--
-- Name: campaign_contacts before_insert_campaign_contact; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_campaign_contact BEFORE INSERT ON sales.campaign_contacts FOR EACH ROW EXECUTE FUNCTION sales.generate_contact_id();


--
-- Name: ticket_convo before_insert_convo; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_convo BEFORE INSERT ON sales.ticket_convo FOR EACH ROW EXECUTE FUNCTION sales.generate_convo_id();


--
-- Name: customers before_insert_customer; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_customer BEFORE INSERT ON sales.customers FOR EACH ROW EXECUTE FUNCTION sales.generate_customer_id();


--
-- Name: sales_invoices before_insert_invoice; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_invoice BEFORE INSERT ON sales.sales_invoices FOR EACH ROW EXECUTE FUNCTION sales.generate_invoice_id();


--
-- Name: opportunities before_insert_opportunity; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_opportunity BEFORE INSERT ON sales.opportunities FOR EACH ROW EXECUTE FUNCTION sales.generate_opportunity_id();


--
-- Name: orders before_insert_orders; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_orders BEFORE INSERT ON sales.orders FOR EACH ROW EXECUTE FUNCTION sales.generate_order_id();


--
-- Name: payments before_insert_payment; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_payment BEFORE INSERT ON sales.payments FOR EACH ROW EXECUTE FUNCTION sales.generate_payment_id();


--
-- Name: product_pricing before_insert_product_pricing; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_product_pricing BEFORE INSERT ON sales.product_pricing FOR EACH ROW EXECUTE FUNCTION public.generate_product_pricing_id();


--
-- Name: quotation before_insert_quotation; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_quotation BEFORE INSERT ON sales.quotation FOR EACH ROW EXECUTE FUNCTION sales.generate_quotation_id();


--
-- Name: return before_insert_return; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_return BEFORE INSERT ON sales.return FOR EACH ROW EXECUTE FUNCTION sales.generate_return_id();


--
-- Name: delivery_note before_insert_shipping; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_shipping BEFORE INSERT ON sales.delivery_note FOR EACH ROW EXECUTE FUNCTION sales.generate_delivery_note_id();


--
-- Name: statement before_insert_statement; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_statement BEFORE INSERT ON sales.statement FOR EACH ROW EXECUTE FUNCTION sales.generate_statement_id();


--
-- Name: statement_item before_insert_statement_item; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_statement_item BEFORE INSERT ON sales.statement_item FOR EACH ROW EXECUTE FUNCTION sales.generate_statement_item_id();


--
-- Name: ticket before_insert_ticket; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER before_insert_ticket BEFORE INSERT ON sales.ticket FOR EACH ROW EXECUTE FUNCTION sales.generate_ticket_id();


--
-- Name: product_pricing trg_calculate_product_pricing; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trg_calculate_product_pricing BEFORE INSERT OR UPDATE ON sales.product_pricing FOR EACH ROW EXECUTE FUNCTION public.calculate_product_pricing();


--
-- Name: customers trg_create_business_partner; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trg_create_business_partner AFTER INSERT ON sales.customers FOR EACH ROW EXECUTE FUNCTION sales.create_business_partner();


--
-- Name: customers trg_create_gl_account; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trg_create_gl_account AFTER INSERT ON sales.customers FOR EACH ROW EXECUTE FUNCTION sales.create_gl_account();


--
-- Name: delivery_note trg_generate_sales_invoice; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trg_generate_sales_invoice AFTER INSERT ON sales.delivery_note FOR EACH ROW EXECUTE FUNCTION sales.generate_invoice();


--
-- Name: orders trg_insert_order_based_on_type; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trg_insert_order_based_on_type AFTER INSERT ON sales.orders FOR EACH ROW EXECUTE FUNCTION public.insert_order_based_on_type();


--
-- Name: customers trg_sync_bpm_customer; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trg_sync_bpm_customer AFTER INSERT OR UPDATE ON sales.customers FOR EACH ROW EXECUTE FUNCTION sales.sync_bpm_customer();


--
-- Name: delivery_note trg_update_order_delivery; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trg_update_order_delivery AFTER UPDATE ON sales.delivery_note FOR EACH ROW EXECUTE FUNCTION sales.update_order_delivery();


--
-- Name: sales_invoices trigger_insert_official_receipts; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trigger_insert_official_receipts AFTER INSERT ON sales.sales_invoices FOR EACH ROW EXECUTE FUNCTION public.insert_into_official_receipts();


--
-- Name: customers trigger_sync_customer_to_gl; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trigger_sync_customer_to_gl AFTER INSERT ON sales.customers FOR EACH ROW EXECUTE FUNCTION accounting.sync_customer_to_gl_accounts();


--
-- Name: statement_item trigger_update_demand_level; Type: TRIGGER; Schema: sales; Owner: postgres
--

CREATE TRIGGER trigger_update_demand_level AFTER INSERT OR DELETE OR UPDATE ON sales.statement_item FOR EACH ROW EXECUTE FUNCTION public.update_demand_level();


--
-- Name: additional_service audit_generic_additional_service; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_additional_service AFTER INSERT OR DELETE OR UPDATE ON services.additional_service FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: additional_service_type audit_generic_additional_service_type; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_additional_service_type AFTER INSERT OR DELETE OR UPDATE ON services.additional_service_type FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: after_analysis_sched audit_generic_after_analysis_sched; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_after_analysis_sched AFTER INSERT OR DELETE OR UPDATE ON services.after_analysis_sched FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: delivery_order audit_generic_delivery_order; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_delivery_order AFTER INSERT OR DELETE OR UPDATE ON services.delivery_order FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_analysis audit_generic_service_analysis; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_analysis AFTER INSERT OR DELETE OR UPDATE ON services.service_analysis FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_billing audit_generic_service_billing; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_billing AFTER INSERT OR DELETE OR UPDATE ON services.service_billing FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_call audit_generic_service_call; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_call AFTER INSERT OR DELETE OR UPDATE ON services.service_call FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_contract audit_generic_service_contract; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_contract AFTER INSERT OR DELETE OR UPDATE ON services.service_contract FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_order audit_generic_service_order; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_order AFTER INSERT OR DELETE OR UPDATE ON services.service_order FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_order_item audit_generic_service_order_item; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_order_item AFTER INSERT OR DELETE OR UPDATE ON services.service_order_item FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_report audit_generic_service_report; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_report AFTER INSERT OR DELETE OR UPDATE ON services.service_report FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: service_request audit_generic_service_request; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER audit_generic_service_request AFTER INSERT OR DELETE OR UPDATE ON services.service_request FOR EACH ROW EXECUTE FUNCTION admin.generic_audit_trigger();


--
-- Name: additional_service before_insert_additional_service; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_additional_service BEFORE INSERT ON services.additional_service FOR EACH ROW EXECUTE FUNCTION services.generate_additional_service_id();


--
-- Name: additional_service_type before_insert_additional_service_type; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_additional_service_type BEFORE INSERT ON services.additional_service_type FOR EACH ROW EXECUTE FUNCTION services.generate_additional_service_type_id();


--
-- Name: after_analysis_sched before_insert_after_analysis_sched; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_after_analysis_sched BEFORE INSERT ON services.after_analysis_sched FOR EACH ROW EXECUTE FUNCTION services.generate_analysis_sched_id();


--
-- Name: delivery_order before_insert_delivery_order; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_delivery_order BEFORE INSERT ON services.delivery_order FOR EACH ROW EXECUTE FUNCTION services.generate_delivery_order_id();


--
-- Name: service_analysis before_insert_service_analysis; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_analysis BEFORE INSERT ON services.service_analysis FOR EACH ROW EXECUTE FUNCTION services.generate_analysis_id();


--
-- Name: service_billing before_insert_service_billing; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_billing BEFORE INSERT ON services.service_billing FOR EACH ROW EXECUTE FUNCTION services.generate_service_billing_id();


--
-- Name: service_call before_insert_service_call; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_call BEFORE INSERT ON services.service_call FOR EACH ROW EXECUTE FUNCTION services.generate_service_call_id();


--
-- Name: service_contract before_insert_service_contract; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_contract BEFORE INSERT ON services.service_contract FOR EACH ROW EXECUTE FUNCTION services.generate_service_contract_id();


--
-- Name: service_order before_insert_service_order; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_order BEFORE INSERT ON services.service_order FOR EACH ROW EXECUTE FUNCTION services.generate_service_order_id();


--
-- Name: service_order_item before_insert_service_order_item; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_order_item BEFORE INSERT ON services.service_order_item FOR EACH ROW EXECUTE FUNCTION services.generate_service_order_item_id();


--
-- Name: service_report before_insert_service_report; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_report BEFORE INSERT ON services.service_report FOR EACH ROW EXECUTE FUNCTION services.generate_report_id();


--
-- Name: service_request before_insert_service_request; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_service_request BEFORE INSERT ON services.service_request FOR EACH ROW EXECUTE FUNCTION services.generate_service_request_id();


--
-- Name: warranty_renewal before_insert_warranty_renewal; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER before_insert_warranty_renewal BEFORE INSERT ON services.warranty_renewal FOR EACH ROW EXECUTE FUNCTION services.generate_renewal_id();


--
-- Name: service_contract trg_update_end_date; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER trg_update_end_date BEFORE UPDATE ON services.service_contract FOR EACH ROW EXECUTE FUNCTION services.update_end_date_trigger();


--
-- Name: service_billing trg_update_service_billing; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER trg_update_service_billing BEFORE INSERT OR UPDATE ON services.service_billing FOR EACH ROW EXECUTE FUNCTION services.update_service_billing();


--
-- Name: service_billing trigger_service_billing_journal; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER trigger_service_billing_journal AFTER INSERT OR UPDATE ON services.service_billing FOR EACH ROW EXECUTE FUNCTION accounting.create_journal_entry_for_service_billing();


--
-- Name: service_order_item trigger_update_prices; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER trigger_update_prices BEFORE INSERT OR UPDATE ON services.service_order_item FOR EACH ROW EXECUTE FUNCTION services.update_service_order_item_prices();


--
-- Name: warranty_renewal trigger_update_renewal_fee_and_end; Type: TRIGGER; Schema: services; Owner: postgres
--

CREATE TRIGGER trigger_update_renewal_fee_and_end BEFORE INSERT OR UPDATE ON services.warranty_renewal FOR EACH ROW EXECUTE FUNCTION services.update_renewal_fee_and_end();


--
-- Name: general_ledger_accounts fk_general_ledger_accounts_chart_of_accounts; Type: FK CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.general_ledger_accounts
    ADD CONSTRAINT fk_general_ledger_accounts_chart_of_accounts FOREIGN KEY (account_code) REFERENCES accounting.chart_of_accounts(account_code);


--
-- Name: journal_entries fk_journal_entries_currency; Type: FK CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.journal_entries
    ADD CONSTRAINT fk_journal_entries_currency FOREIGN KEY (currency_id) REFERENCES admin.currency(currency_id);


--
-- Name: journal_entry_lines fk_journal_entry_lines_gl_account; Type: FK CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.journal_entry_lines
    ADD CONSTRAINT fk_journal_entry_lines_gl_account FOREIGN KEY (gl_account_id) REFERENCES accounting.general_ledger_accounts(gl_account_id);


--
-- Name: journal_entry_lines fk_journal_entry_lines_journal; Type: FK CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.journal_entry_lines
    ADD CONSTRAINT fk_journal_entry_lines_journal FOREIGN KEY (journal_id) REFERENCES accounting.journal_entries(journal_id);


--
-- Name: official_receipts fk_official_receipts_invoice; Type: FK CONSTRAINT; Schema: accounting; Owner: postgres
--

ALTER TABLE ONLY accounting.official_receipts
    ADD CONSTRAINT fk_official_receipts_invoice FOREIGN KEY (invoice_id) REFERENCES sales.sales_invoices(invoice_id);


--
-- Name: item_master_data fk_assets_item; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.item_master_data
    ADD CONSTRAINT fk_assets_item FOREIGN KEY (asset_id) REFERENCES admin.assets(asset_id) ON DELETE CASCADE;


--
-- Name: audit_log fk_audit_log_user; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.audit_log
    ADD CONSTRAINT fk_audit_log_user FOREIGN KEY (user_id) REFERENCES admin.users(user_id) ON DELETE CASCADE;


--
-- Name: business_partner_master fk_business_partner_customer; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.business_partner_master
    ADD CONSTRAINT fk_business_partner_customer FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id) ON DELETE CASCADE;


--
-- Name: business_partner_master fk_business_partner_employee; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.business_partner_master
    ADD CONSTRAINT fk_business_partner_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: business_partner_master fk_business_partner_vendor; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.business_partner_master
    ADD CONSTRAINT fk_business_partner_vendor FOREIGN KEY (vendor_code) REFERENCES admin.vendor(vendor_code) ON DELETE CASCADE;


--
-- Name: assets fk_document_assets; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.assets
    ADD CONSTRAINT fk_document_assets FOREIGN KEY (content_id) REFERENCES operations.document_items(content_id) ON DELETE CASCADE;


--
-- Name: products fk_document_products; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.products
    ADD CONSTRAINT fk_document_products FOREIGN KEY (content_id) REFERENCES operations.document_items(content_id) ON DELETE CASCADE;


--
-- Name: raw_materials fk_material_vendor; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.raw_materials
    ADD CONSTRAINT fk_material_vendor FOREIGN KEY (vendor_code) REFERENCES admin.vendor(vendor_code);


--
-- Name: item_master_data fk_products_item; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.item_master_data
    ADD CONSTRAINT fk_products_item FOREIGN KEY (product_id) REFERENCES admin.products(product_id) ON DELETE CASCADE;


--
-- Name: products fk_products_policy; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.products
    ADD CONSTRAINT fk_products_policy FOREIGN KEY (policy_id) REFERENCES admin.policies(policy_id) ON DELETE CASCADE;


--
-- Name: item_master_data fk_raw_materials_item; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.item_master_data
    ADD CONSTRAINT fk_raw_materials_item FOREIGN KEY (material_id) REFERENCES admin.raw_materials(material_id) ON DELETE CASCADE;


--
-- Name: users fk_users_employee; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.users
    ADD CONSTRAINT fk_users_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: users fk_users_role; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.users
    ADD CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES admin.roles_permission(role_id) ON DELETE CASCADE;


--
-- Name: vendor fk_vendor_application; Type: FK CONSTRAINT; Schema: admin; Owner: postgres
--

ALTER TABLE ONLY admin.vendor
    ADD CONSTRAINT fk_vendor_application FOREIGN KEY (application_reference) REFERENCES purchasing.vendor_application(application_reference) ON DELETE CASCADE;


--
-- Name: billing_receipt fk_billing_receipt_delivery_receipt; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.billing_receipt
    ADD CONSTRAINT fk_billing_receipt_delivery_receipt FOREIGN KEY (delivery_receipt_id) REFERENCES distribution.delivery_receipt(delivery_receipt_id);


--
-- Name: billing_receipt fk_billing_receipt_sales_invoice; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.billing_receipt
    ADD CONSTRAINT fk_billing_receipt_sales_invoice FOREIGN KEY (sales_invoice_id) REFERENCES sales.sales_invoices(invoice_id);


--
-- Name: billing_receipt fk_billing_receipt_service_billing; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.billing_receipt
    ADD CONSTRAINT fk_billing_receipt_service_billing FOREIGN KEY (service_billing_id) REFERENCES services.service_billing(service_billing_id);


--
-- Name: carrier fk_carrier_carrier_name; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.carrier
    ADD CONSTRAINT fk_carrier_carrier_name FOREIGN KEY (carrier_name) REFERENCES human_resources.employees(employee_id);


--
-- Name: delivery_order fk_delivery_order_approval_request; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_order
    ADD CONSTRAINT fk_delivery_order_approval_request FOREIGN KEY (approval_request_id) REFERENCES distribution.logistics_approval_request(approval_request_id);


--
-- Name: delivery_order fk_delivery_order_content; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_order
    ADD CONSTRAINT fk_delivery_order_content FOREIGN KEY (content_id) REFERENCES operations.document_items(content_id);


--
-- Name: delivery_order fk_delivery_order_delivery_order; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_order
    ADD CONSTRAINT fk_delivery_order_delivery_order FOREIGN KEY (service_order_id) REFERENCES services.delivery_order(delivery_order_id);


--
-- Name: delivery_order fk_delivery_order_sales_order; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_order
    ADD CONSTRAINT fk_delivery_order_sales_order FOREIGN KEY (sales_order_id) REFERENCES sales.orders(order_id);


--
-- Name: delivery_order fk_delivery_order_stock_transfer; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_order
    ADD CONSTRAINT fk_delivery_order_stock_transfer FOREIGN KEY (stock_transfer_id) REFERENCES inventory.warehouse_movement(movement_id);


--
-- Name: delivery_receipt fk_delivery_receipt_customer; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_receipt
    ADD CONSTRAINT fk_delivery_receipt_customer FOREIGN KEY (received_by) REFERENCES sales.customers(customer_id);


--
-- Name: delivery_receipt fk_delivery_receipt_shipment; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.delivery_receipt
    ADD CONSTRAINT fk_delivery_receipt_shipment FOREIGN KEY (shipment_id) REFERENCES distribution.shipment_details(shipment_id);


--
-- Name: failed_shipment fk_failed_shipment_shipment; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.failed_shipment
    ADD CONSTRAINT fk_failed_shipment_shipment FOREIGN KEY (shipment_id) REFERENCES distribution.shipment_details(shipment_id);


--
-- Name: goods_issue fk_goods_issue_billing_receipt; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.goods_issue
    ADD CONSTRAINT fk_goods_issue_billing_receipt FOREIGN KEY (billing_receipt_id) REFERENCES distribution.billing_receipt(billing_receipt_id);


--
-- Name: goods_issue fk_goods_issue_employee; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.goods_issue
    ADD CONSTRAINT fk_goods_issue_employee FOREIGN KEY (issued_by) REFERENCES human_resources.employees(employee_id);


--
-- Name: logistics_approval_request fk_logistics_approval_request_delivery_order; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.logistics_approval_request
    ADD CONSTRAINT fk_logistics_approval_request_delivery_order FOREIGN KEY (del_order_id) REFERENCES distribution.delivery_order(del_order_id);


--
-- Name: logistics_approval_request fk_logistics_approval_request_employee; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.logistics_approval_request
    ADD CONSTRAINT fk_logistics_approval_request_employee FOREIGN KEY (approved_by) REFERENCES human_resources.employees(employee_id);


--
-- Name: operational_cost fk_operational_cost_packing_cost; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.operational_cost
    ADD CONSTRAINT fk_operational_cost_packing_cost FOREIGN KEY (packing_cost_id) REFERENCES distribution.packing_cost(packing_cost_id);


--
-- Name: operational_cost fk_operational_cost_shipping_cost; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.operational_cost
    ADD CONSTRAINT fk_operational_cost_shipping_cost FOREIGN KEY (shipping_cost_id) REFERENCES distribution.shipping_cost(shipping_cost_id);


--
-- Name: packing_list fk_packing_list_employee; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.packing_list
    ADD CONSTRAINT fk_packing_list_employee FOREIGN KEY (packed_by) REFERENCES human_resources.employees(employee_id);


--
-- Name: packing_list fk_packing_list_packing_cost; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.packing_list
    ADD CONSTRAINT fk_packing_list_packing_cost FOREIGN KEY (packing_cost_id) REFERENCES distribution.packing_cost(packing_cost_id);


--
-- Name: packing_list fk_packing_list_picking_list; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.packing_list
    ADD CONSTRAINT fk_packing_list_picking_list FOREIGN KEY (picking_list_id) REFERENCES distribution.picking_list(picking_list_id);


--
-- Name: picking_list fk_picking_list_approval_request; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.picking_list
    ADD CONSTRAINT fk_picking_list_approval_request FOREIGN KEY (approval_request_id) REFERENCES distribution.logistics_approval_request(approval_request_id);


--
-- Name: picking_list fk_picking_list_employee; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.picking_list
    ADD CONSTRAINT fk_picking_list_employee FOREIGN KEY (picked_by) REFERENCES human_resources.employees(employee_id);


--
-- Name: picking_list fk_picking_list_warehouse; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.picking_list
    ADD CONSTRAINT fk_picking_list_warehouse FOREIGN KEY (warehouse_id) REFERENCES admin.warehouse(warehouse_id);


--
-- Name: rejection fk_rejection_delivery_receipt; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.rejection
    ADD CONSTRAINT fk_rejection_delivery_receipt FOREIGN KEY (delivery_receipt_id) REFERENCES distribution.delivery_receipt(delivery_receipt_id);


--
-- Name: rework_order fk_rework_order_employee; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.rework_order
    ADD CONSTRAINT fk_rework_order_employee FOREIGN KEY (assigned_to) REFERENCES human_resources.employees(employee_id);


--
-- Name: rework_order fk_rework_order_failed_shipment; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.rework_order
    ADD CONSTRAINT fk_rework_order_failed_shipment FOREIGN KEY (failed_shipment_id) REFERENCES distribution.failed_shipment(failed_shipment_id);


--
-- Name: rework_order fk_rework_order_rejection; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.rework_order
    ADD CONSTRAINT fk_rework_order_rejection FOREIGN KEY (rejection_id) REFERENCES distribution.rejection(rejection_id);


--
-- Name: shipment_details fk_shipment_details_carrier; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.shipment_details
    ADD CONSTRAINT fk_shipment_details_carrier FOREIGN KEY (carrier_id) REFERENCES distribution.carrier(carrier_id);


--
-- Name: shipment_details fk_shipment_details_packing_list; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.shipment_details
    ADD CONSTRAINT fk_shipment_details_packing_list FOREIGN KEY (packing_list_id) REFERENCES distribution.packing_list(packing_list_id);


--
-- Name: shipment_details fk_shipment_details_shipping_cost; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.shipment_details
    ADD CONSTRAINT fk_shipment_details_shipping_cost FOREIGN KEY (shipping_cost_id) REFERENCES distribution.shipping_cost(shipping_cost_id);


--
-- Name: shipping_cost fk_shipping_cost_packing_list; Type: FK CONSTRAINT; Schema: distribution; Owner: postgres
--

ALTER TABLE ONLY distribution.shipping_cost
    ADD CONSTRAINT fk_shipping_cost_packing_list FOREIGN KEY (packing_list_id) REFERENCES distribution.packing_list(packing_list_id);


--
-- Name: budget_allocation fk_budget_allocation; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_allocation
    ADD CONSTRAINT fk_budget_allocation FOREIGN KEY (budget_approvals_id) REFERENCES finance.budget_approvals(budget_approvals_id);


--
-- Name: budget_approvals fk_budget_approvals_validations; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_approvals
    ADD CONSTRAINT fk_budget_approvals_validations FOREIGN KEY (validation_id) REFERENCES finance.budget_validations(validation_id);


--
-- Name: budget_request_form fk_budget_request_form; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_request_form
    ADD CONSTRAINT fk_budget_request_form FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id);


--
-- Name: budget_returns_form fk_budget_returns_form_dept; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_returns_form
    ADD CONSTRAINT fk_budget_returns_form_dept FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id);


--
-- Name: budget_returns_form fk_budget_returns_form_request_2; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_returns_form
    ADD CONSTRAINT fk_budget_returns_form_request_2 FOREIGN KEY (budget_request_id) REFERENCES finance.budget_request_form(budget_request_id);


--
-- Name: budget_submission fk_budget_submission; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_submission
    ADD CONSTRAINT fk_budget_submission FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id);


--
-- Name: budget_validations fk_budget_validations; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_validations
    ADD CONSTRAINT fk_budget_validations FOREIGN KEY (budget_submission_id) REFERENCES finance.budget_submission(budget_submission_id);


--
-- Name: budget_validations fk_budget_validations_validate_2; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_validations
    ADD CONSTRAINT fk_budget_validations_validate_2 FOREIGN KEY (budget_request_id) REFERENCES finance.budget_request_form(budget_request_id);


--
-- Name: budget_validations fk_budget_validations_validate_3; Type: FK CONSTRAINT; Schema: finance; Owner: postgres
--

ALTER TABLE ONLY finance.budget_validations
    ADD CONSTRAINT fk_budget_validations_validate_3 FOREIGN KEY (budget_return_id) REFERENCES finance.budget_returns_form(budget_return_id);


--
-- Name: attendance_tracking fk_attendance_date; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.attendance_tracking
    ADD CONSTRAINT fk_attendance_date FOREIGN KEY (date) REFERENCES human_resources.calendar_dates(date);


--
-- Name: attendance_tracking fk_attendance_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.attendance_tracking
    ADD CONSTRAINT fk_attendance_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: candidates fk_candidate_job; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.candidates
    ADD CONSTRAINT fk_candidate_job FOREIGN KEY (job_id) REFERENCES human_resources.job_posting(job_id) ON DELETE CASCADE;


--
-- Name: workforce_allocation fk_current_dept; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.workforce_allocation
    ADD CONSTRAINT fk_current_dept FOREIGN KEY (current_dept_id) REFERENCES human_resources.departments(dept_id) ON DELETE RESTRICT;


--
-- Name: department_superiors fk_department_superiors_dept; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.department_superiors
    ADD CONSTRAINT fk_department_superiors_dept FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id) ON DELETE CASCADE;


--
-- Name: department_superiors fk_department_superiors_position; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.department_superiors
    ADD CONSTRAINT fk_department_superiors_position FOREIGN KEY (position_id) REFERENCES human_resources.positions(position_id) ON DELETE CASCADE;


--
-- Name: workforce_allocation fk_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.workforce_allocation
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE RESTRICT;


--
-- Name: employee_performance fk_employee_performance_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_performance
    ADD CONSTRAINT fk_employee_performance_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: employee_performance fk_employee_performance_superior; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_performance
    ADD CONSTRAINT fk_employee_performance_superior FOREIGN KEY (immediate_superior_id) REFERENCES human_resources.employees(employee_id) ON DELETE SET NULL;


--
-- Name: employees fk_employees_dept; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employees
    ADD CONSTRAINT fk_employees_dept FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id) ON DELETE RESTRICT;


--
-- Name: employees fk_employees_position; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employees
    ADD CONSTRAINT fk_employees_position FOREIGN KEY (position_id) REFERENCES human_resources.positions(position_id) ON DELETE SET NULL;


--
-- Name: employees fk_employees_superior; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employees
    ADD CONSTRAINT fk_employees_superior FOREIGN KEY (reports_to) REFERENCES human_resources.employees(employee_id) ON DELETE SET NULL;


--
-- Name: employees fk_employees_user; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employees
    ADD CONSTRAINT fk_employees_user FOREIGN KEY (user_id) REFERENCES admin.users(user_id) ON DELETE SET NULL;


--
-- Name: job_posting fk_finance_approval; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_posting
    ADD CONSTRAINT fk_finance_approval FOREIGN KEY (finance_approval_id) REFERENCES finance.budget_submission(budget_submission_id) ON DELETE SET NULL;


--
-- Name: workforce_allocation fk_hr_approver; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.workforce_allocation
    ADD CONSTRAINT fk_hr_approver FOREIGN KEY (hr_approver_id) REFERENCES human_resources.employees(employee_id) ON DELETE SET NULL;


--
-- Name: job_posting fk_job_department; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_posting
    ADD CONSTRAINT fk_job_department FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id) ON DELETE RESTRICT;


--
-- Name: job_posting fk_job_position; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.job_posting
    ADD CONSTRAINT fk_job_position FOREIGN KEY (position_id) REFERENCES human_resources.positions(position_id) ON DELETE RESTRICT;


--
-- Name: employee_leave_balances fk_leave_balance_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_leave_balances
    ADD CONSTRAINT fk_leave_balance_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: leave_requests fk_leave_department; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.leave_requests
    ADD CONSTRAINT fk_leave_department FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id) ON DELETE RESTRICT;


--
-- Name: leave_requests fk_leave_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.leave_requests
    ADD CONSTRAINT fk_leave_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: leave_requests fk_leave_superior; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.leave_requests
    ADD CONSTRAINT fk_leave_superior FOREIGN KEY (immediate_superior_id) REFERENCES human_resources.employees(employee_id) ON DELETE SET NULL;


--
-- Name: leave_requests fk_management_approval; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.leave_requests
    ADD CONSTRAINT fk_management_approval FOREIGN KEY (management_approval_id) REFERENCES management.management_approvals(approval_id) ON DELETE SET NULL;


--
-- Name: payroll fk_payroll_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.payroll
    ADD CONSTRAINT fk_payroll_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE RESTRICT;


--
-- Name: workforce_allocation fk_requesting_dept; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.workforce_allocation
    ADD CONSTRAINT fk_requesting_dept FOREIGN KEY (requesting_dept_id) REFERENCES human_resources.departments(dept_id) ON DELETE RESTRICT;


--
-- Name: resignations fk_resignation_approver; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.resignations
    ADD CONSTRAINT fk_resignation_approver FOREIGN KEY (hr_approver_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: resignations fk_resignation_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.resignations
    ADD CONSTRAINT fk_resignation_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: employee_salary fk_salary_employee; Type: FK CONSTRAINT; Schema: human_resources; Owner: postgres
--

ALTER TABLE ONLY human_resources.employee_salary
    ADD CONSTRAINT fk_salary_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: inventory_item fk_asset_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item
    ADD CONSTRAINT fk_asset_id FOREIGN KEY (asset_id) REFERENCES admin.assets(asset_id) ON DELETE CASCADE;


--
-- Name: warehouse_movement fk_destination; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement
    ADD CONSTRAINT fk_destination FOREIGN KEY (destination) REFERENCES admin.warehouse(warehouse_id) ON DELETE CASCADE;


--
-- Name: inventory_cyclic_counts fk_employee_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_cyclic_counts
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: inventory_adjustments fk_employee_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_adjustments
    ADD CONSTRAINT fk_employee_id FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: inventory_cyclic_counts fk_inventory_item; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_cyclic_counts
    ADD CONSTRAINT fk_inventory_item FOREIGN KEY (inventory_item_id) REFERENCES inventory.inventory_item(inventory_item_id) ON DELETE CASCADE;


--
-- Name: deprecation_report fk_inventory_item; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.deprecation_report
    ADD CONSTRAINT fk_inventory_item FOREIGN KEY (inventory_item_id) REFERENCES inventory.inventory_item(inventory_item_id) ON DELETE CASCADE;


--
-- Name: expiry_report fk_inventory_item; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.expiry_report
    ADD CONSTRAINT fk_inventory_item FOREIGN KEY (inventory_item_id) REFERENCES inventory.inventory_item(inventory_item_id) ON DELETE CASCADE;


--
-- Name: warehouse_movement_items fk_inventory_item; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement_items
    ADD CONSTRAINT fk_inventory_item FOREIGN KEY (inventory_item_id) REFERENCES inventory.inventory_item(inventory_item_id) ON DELETE CASCADE;


--
-- Name: inventory_item_threshold fk_item_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item_threshold
    ADD CONSTRAINT fk_item_id FOREIGN KEY (item_id) REFERENCES admin.item_master_data(item_id) ON DELETE CASCADE;


--
-- Name: inventory_adjustments fk_item_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_adjustments
    ADD CONSTRAINT fk_item_id FOREIGN KEY (item_id) REFERENCES admin.item_master_data(item_id) ON DELETE CASCADE;


--
-- Name: inventory_item fk_material_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item
    ADD CONSTRAINT fk_material_id FOREIGN KEY (material_id) REFERENCES admin.raw_materials(material_id) ON DELETE CASCADE;


--
-- Name: inventory_item fk_productdocu_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item
    ADD CONSTRAINT fk_productdocu_id FOREIGN KEY (productdocu_id) REFERENCES operations.product_document_items(productdocu_id) ON DELETE CASCADE;


--
-- Name: warehouse_movement fk_reference_id_order; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement
    ADD CONSTRAINT fk_reference_id_order FOREIGN KEY (reference_id_order) REFERENCES sales.orders(order_id) ON DELETE CASCADE;


--
-- Name: warehouse_movement fk_reference_id_purchase_order; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement
    ADD CONSTRAINT fk_reference_id_purchase_order FOREIGN KEY (reference_id_purchase_order) REFERENCES purchasing.purchase_order(purchase_id) ON DELETE CASCADE;


--
-- Name: inventory_item fk_serial_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item
    ADD CONSTRAINT fk_serial_id FOREIGN KEY (serial_id) REFERENCES operations.serial_tracking(serial_id) ON DELETE CASCADE;


--
-- Name: warehouse_movement fk_source; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement
    ADD CONSTRAINT fk_source FOREIGN KEY (source) REFERENCES admin.warehouse(warehouse_id) ON DELETE CASCADE;


--
-- Name: inventory_item fk_warehouse_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_item
    ADD CONSTRAINT fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES admin.warehouse(warehouse_id) ON DELETE CASCADE;


--
-- Name: inventory_cyclic_counts fk_warehouse_id; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.inventory_cyclic_counts
    ADD CONSTRAINT fk_warehouse_id FOREIGN KEY (warehouse_id) REFERENCES admin.warehouse(warehouse_id) ON DELETE CASCADE;


--
-- Name: warehouse_movement_items fk_warehouse_movement; Type: FK CONSTRAINT; Schema: inventory; Owner: postgres
--

ALTER TABLE ONLY inventory.warehouse_movement_items
    ADD CONSTRAINT fk_warehouse_movement FOREIGN KEY (movement_id) REFERENCES inventory.warehouse_movement(movement_id) ON DELETE CASCADE;


--
-- Name: management_approvals fk_external_id; Type: FK CONSTRAINT; Schema: management; Owner: postgres
--

ALTER TABLE ONLY management.management_approvals
    ADD CONSTRAINT fk_external_id FOREIGN KEY (external_id) REFERENCES operations.external_module(external_id) ON DELETE SET NULL;


--
-- Name: management_approvals fk_request_id; Type: FK CONSTRAINT; Schema: management; Owner: postgres
--

ALTER TABLE ONLY management.management_approvals
    ADD CONSTRAINT fk_request_id FOREIGN KEY (request_id_all) REFERENCES services.service_request(service_request_id) ON DELETE SET NULL;


--
-- Name: management_approvals fk_user_id; Type: FK CONSTRAINT; Schema: management; Owner: postgres
--

ALTER TABLE ONLY management.management_approvals
    ADD CONSTRAINT fk_user_id FOREIGN KEY (checked_by) REFERENCES admin.users(user_id);


--
-- Name: bill_of_materials fk_bill_of_materials_labor_cost_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.bill_of_materials
    ADD CONSTRAINT fk_bill_of_materials_labor_cost_id FOREIGN KEY (labor_cost_id) REFERENCES mrp.labor_cost(labor_cost_id);


--
-- Name: bill_of_materials fk_bill_of_materials_product_mats_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.bill_of_materials
    ADD CONSTRAINT fk_bill_of_materials_product_mats_id FOREIGN KEY (product_mats_id) REFERENCES mrp.product_mats(product_mats_id);


--
-- Name: bill_of_materials fk_bill_of_materials_production_order_detail_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.bill_of_materials
    ADD CONSTRAINT fk_bill_of_materials_production_order_detail_id FOREIGN KEY (production_order_detail_id) REFERENCES production.production_orders_details(production_order_detail_id);


--
-- Name: bill_of_materials fk_bill_of_materials_project_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.bill_of_materials
    ADD CONSTRAINT fk_bill_of_materials_project_id FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id);


--
-- Name: labor_cost fk_labor_cost_labor_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.labor_cost
    ADD CONSTRAINT fk_labor_cost_labor_id FOREIGN KEY (labor_id) REFERENCES production.labor(labor_id);


--
-- Name: labor_cost fk_labor_cost_salary_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.labor_cost
    ADD CONSTRAINT fk_labor_cost_salary_id FOREIGN KEY (salary_id) REFERENCES human_resources.employee_salary(salary_id);


--
-- Name: non_project_order_pricing fk_non_project_order_pricing_order_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.non_project_order_pricing
    ADD CONSTRAINT fk_non_project_order_pricing_order_id FOREIGN KEY (order_id) REFERENCES sales.orders(order_id);


--
-- Name: principal_items fk_principal_items_service_item; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.principal_items
    ADD CONSTRAINT fk_principal_items_service_item FOREIGN KEY (item_id) REFERENCES admin.item_master_data(item_id);


--
-- Name: principal_items fk_principal_items_service_order_item; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.principal_items
    ADD CONSTRAINT fk_principal_items_service_order_item FOREIGN KEY (service_order_item_id) REFERENCES services.service_order_item(service_order_item_id);


--
-- Name: product_mats fk_product_mats_material_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.product_mats
    ADD CONSTRAINT fk_product_mats_material_id FOREIGN KEY (material_id) REFERENCES admin.raw_materials(material_id);


--
-- Name: product_mats fk_product_mats_product_id; Type: FK CONSTRAINT; Schema: mrp; Owner: postgres
--

ALTER TABLE ONLY mrp.product_mats
    ADD CONSTRAINT fk_product_mats_product_id FOREIGN KEY (product_id) REFERENCES admin.products(product_id);


--
-- Name: labor fk_labor_employee; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.labor
    ADD CONSTRAINT fk_labor_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: labor fk_labor_production_order; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.labor
    ADD CONSTRAINT fk_labor_production_order FOREIGN KEY (production_order_id) REFERENCES production.production_orders_header(production_order_id);


--
-- Name: production_orders_header fk_production_orders_bom; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.production_orders_header
    ADD CONSTRAINT fk_production_orders_bom FOREIGN KEY (bom_id) REFERENCES mrp.bill_of_materials(bom_id);


--
-- Name: production_orders_details fk_production_orders_details_equipment; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.production_orders_details
    ADD CONSTRAINT fk_production_orders_details_equipment FOREIGN KEY (equipment_id) REFERENCES production.equipment(equipment_id);


--
-- Name: production_orders_details fk_production_orders_details_external; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.production_orders_details
    ADD CONSTRAINT fk_production_orders_details_external FOREIGN KEY (external_id) REFERENCES operations.external_module(external_id);


--
-- Name: production_orders_details fk_production_orders_details_production_order; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.production_orders_details
    ADD CONSTRAINT fk_production_orders_details_production_order FOREIGN KEY (production_order_id) REFERENCES production.production_orders_header(production_order_id);


--
-- Name: production_orders_header fk_production_orders_task; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.production_orders_header
    ADD CONSTRAINT fk_production_orders_task FOREIGN KEY (task_id) REFERENCES project_management.external_project_task_list(task_id);


--
-- Name: project_equipment fk_project_equipment_equipment; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.project_equipment
    ADD CONSTRAINT fk_project_equipment_equipment FOREIGN KEY (equipment_id) REFERENCES production.equipment(equipment_id);


--
-- Name: project_equipment fk_project_equipment_product; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.project_equipment
    ADD CONSTRAINT fk_project_equipment_product FOREIGN KEY (product_id) REFERENCES admin.products(product_id);


--
-- Name: rework_cost fk_rework_cost_production_order; Type: FK CONSTRAINT; Schema: production; Owner: postgres
--

ALTER TABLE ONLY production.rework_cost
    ADD CONSTRAINT fk_rework_cost_production_order FOREIGN KEY (production_order_id) REFERENCES production.production_orders_header(production_order_id);


--
-- Name: external_project_equipments fk_ext_project_equipments_prod; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_equipments
    ADD CONSTRAINT fk_ext_project_equipments_prod FOREIGN KEY (project_equipment_id) REFERENCES production.project_equipment(project_equipment_id) ON DELETE CASCADE;


--
-- Name: external_project_equipments fk_ext_project_equipments_projid; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_equipments
    ADD CONSTRAINT fk_ext_project_equipments_projid FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id) ON DELETE CASCADE;


--
-- Name: external_project_request fk_external_project_approval; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_request
    ADD CONSTRAINT fk_external_project_approval FOREIGN KEY (approval_id) REFERENCES management.management_approvals(approval_id) ON DELETE CASCADE;


--
-- Name: external_project_cost_management fk_external_project_bom_id; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_cost_management
    ADD CONSTRAINT fk_external_project_bom_id FOREIGN KEY (bom_id) REFERENCES mrp.bill_of_materials(bom_id) ON DELETE CASCADE;


--
-- Name: external_project_cost_management fk_external_project_cost_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_cost_management
    ADD CONSTRAINT fk_external_project_cost_project FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id) ON DELETE CASCADE;


--
-- Name: external_project_details fk_external_project_details_request; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_details
    ADD CONSTRAINT fk_external_project_details_request FOREIGN KEY (ext_project_request_id) REFERENCES project_management.external_project_request(ext_project_request_id) ON DELETE CASCADE;


--
-- Name: external_project_labor fk_external_project_labor_employee; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_labor
    ADD CONSTRAINT fk_external_project_labor_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: external_project_labor fk_external_project_labor_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_labor
    ADD CONSTRAINT fk_external_project_labor_project FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id) ON DELETE CASCADE;


--
-- Name: external_project_request fk_external_project_request_item; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_request
    ADD CONSTRAINT fk_external_project_request_item FOREIGN KEY (item_id) REFERENCES sales.orders(order_id) ON DELETE CASCADE;


--
-- Name: external_project_task_list fk_external_project_task_labor; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_task_list
    ADD CONSTRAINT fk_external_project_task_labor FOREIGN KEY (project_labor_id) REFERENCES project_management.external_project_labor(project_labor_id) ON DELETE CASCADE;


--
-- Name: external_project_task_list fk_external_project_task_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_task_list
    ADD CONSTRAINT fk_external_project_task_project FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id) ON DELETE CASCADE;


--
-- Name: external_project_tracking fk_external_project_tracking_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_tracking
    ADD CONSTRAINT fk_external_project_tracking_project FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id) ON DELETE CASCADE;


--
-- Name: external_project_tracking fk_external_project_tracking_warranty; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_tracking
    ADD CONSTRAINT fk_external_project_tracking_warranty FOREIGN KEY (project_warranty_id) REFERENCES project_management.external_project_warranty(project_warranty_id) ON DELETE CASCADE;


--
-- Name: external_project_warranty fk_external_project_warranty_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.external_project_warranty
    ADD CONSTRAINT fk_external_project_warranty_project FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id) ON DELETE CASCADE;


--
-- Name: internal_project_cost_management fk_internal_project_cm_bomid; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_cost_management
    ADD CONSTRAINT fk_internal_project_cm_bomid FOREIGN KEY (bom_id) REFERENCES mrp.bill_of_materials(bom_id) ON DELETE CASCADE;


--
-- Name: internal_project_cost_management fk_internal_project_cm_intprojid; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_cost_management
    ADD CONSTRAINT fk_internal_project_cm_intprojid FOREIGN KEY (intrnl_project_id) REFERENCES project_management.internal_project_details(intrnl_project_id) ON DELETE CASCADE;


--
-- Name: internal_project_details fk_internal_project_details_request; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_details
    ADD CONSTRAINT fk_internal_project_details_request FOREIGN KEY (project_request_id) REFERENCES project_management.internal_project_request(project_request_id) ON DELETE CASCADE;


--
-- Name: internal_project_labor fk_internal_project_labor_employee; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_labor
    ADD CONSTRAINT fk_internal_project_labor_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: internal_project_labor fk_internal_project_labor_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_labor
    ADD CONSTRAINT fk_internal_project_labor_project FOREIGN KEY (intrnl_project_id) REFERENCES project_management.internal_project_details(intrnl_project_id) ON DELETE CASCADE;


--
-- Name: internal_project_request fk_internal_project_request_dept; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_request
    ADD CONSTRAINT fk_internal_project_request_dept FOREIGN KEY (dept_id) REFERENCES human_resources.departments(dept_id) ON DELETE CASCADE;


--
-- Name: internal_project_request fk_internal_project_request_employee; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_request
    ADD CONSTRAINT fk_internal_project_request_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: internal_project_task_list fk_internal_project_task_list_labor; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_task_list
    ADD CONSTRAINT fk_internal_project_task_list_labor FOREIGN KEY (intrnl_project_labor_id) REFERENCES project_management.internal_project_labor(intrnl_project_labor_id) ON DELETE CASCADE;


--
-- Name: internal_project_task_list fk_internal_project_task_list_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_task_list
    ADD CONSTRAINT fk_internal_project_task_list_project FOREIGN KEY (intrnl_project_id) REFERENCES project_management.internal_project_details(intrnl_project_id) ON DELETE CASCADE;


--
-- Name: internal_project_tracking fk_internal_project_tracking_project; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_tracking
    ADD CONSTRAINT fk_internal_project_tracking_project FOREIGN KEY (intrnl_project_id) REFERENCES project_management.internal_project_details(intrnl_project_id) ON DELETE CASCADE;


--
-- Name: internal_project_details fk_intrnl_project_approval_management; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.internal_project_details
    ADD CONSTRAINT fk_intrnl_project_approval_management FOREIGN KEY (approval_id) REFERENCES management.management_approvals(approval_id) ON DELETE CASCADE;


--
-- Name: report_monitoring fk_intrnl_project_id_rm; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.report_monitoring
    ADD CONSTRAINT fk_intrnl_project_id_rm FOREIGN KEY (intrnl_project_id) REFERENCES project_management.internal_project_details(intrnl_project_id) ON DELETE CASCADE;


--
-- Name: report_monitoring fk_project_id_rm; Type: FK CONSTRAINT; Schema: project_management; Owner: postgres
--

ALTER TABLE ONLY project_management.report_monitoring
    ADD CONSTRAINT fk_project_id_rm FOREIGN KEY (project_id) REFERENCES project_management.external_project_details(project_id) ON DELETE CASCADE;


--
-- Name: purchase_requests fk_approval; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_requests
    ADD CONSTRAINT fk_approval FOREIGN KEY (approval_id) REFERENCES management.management_approvals(approval_id) ON DELETE CASCADE;


--
-- Name: quotation_contents fk_asset; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.quotation_contents
    ADD CONSTRAINT fk_asset FOREIGN KEY (asset_id) REFERENCES admin.assets(asset_id) ON DELETE CASCADE;


--
-- Name: purchase_invoice fk_content; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_invoice
    ADD CONSTRAINT fk_content FOREIGN KEY (content_id) REFERENCES operations.document_items(content_id) ON DELETE CASCADE;


--
-- Name: purchase_requests fk_employee; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_requests
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: batch_inspection fk_employee; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.batch_inspection
    ADD CONSTRAINT fk_employee FOREIGN KEY (employee_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: credit_memo fk_inspection; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.credit_memo
    ADD CONSTRAINT fk_inspection FOREIGN KEY (inspection_id) REFERENCES purchasing.batch_inspection(inspection_id) ON DELETE CASCADE;


--
-- Name: credit_memo fk_invoice; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.credit_memo
    ADD CONSTRAINT fk_invoice FOREIGN KEY (invoice_id) REFERENCES purchasing.purchase_invoice(invoice_id) ON DELETE CASCADE;


--
-- Name: quotation_contents fk_material; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.quotation_contents
    ADD CONSTRAINT fk_material FOREIGN KEY (material_id) REFERENCES admin.raw_materials(material_id) ON DELETE CASCADE;


--
-- Name: received_shipments fk_purchase; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.received_shipments
    ADD CONSTRAINT fk_purchase FOREIGN KEY (purchase_id) REFERENCES purchasing.purchase_order(purchase_id) ON DELETE CASCADE;


--
-- Name: purchase_order fk_quotation; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_order
    ADD CONSTRAINT fk_quotation FOREIGN KEY (quotation_id) REFERENCES purchasing.purchase_quotation(quotation_id) ON DELETE CASCADE;


--
-- Name: quotation_contents fk_request; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.quotation_contents
    ADD CONSTRAINT fk_request FOREIGN KEY (request_id) REFERENCES purchasing.purchase_requests(request_id) ON DELETE CASCADE;


--
-- Name: purchase_quotation fk_request; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_quotation
    ADD CONSTRAINT fk_request FOREIGN KEY (request_id) REFERENCES purchasing.purchase_requests(request_id) ON DELETE CASCADE;


--
-- Name: batch_inspection fk_shipment; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.batch_inspection
    ADD CONSTRAINT fk_shipment FOREIGN KEY (shipment_id) REFERENCES purchasing.received_shipments(shipment_id) ON DELETE CASCADE;


--
-- Name: purchase_quotation fk_vendor; Type: FK CONSTRAINT; Schema: purchasing; Owner: postgres
--

ALTER TABLE ONLY purchasing.purchase_quotation
    ADD CONSTRAINT fk_vendor FOREIGN KEY (vendor_code) REFERENCES admin.vendor(vendor_code) ON DELETE CASCADE;


--
-- Name: statement_item fk_additional_service_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.statement_item
    ADD CONSTRAINT fk_additional_service_id FOREIGN KEY (additional_service_id) REFERENCES services.additional_service(additional_service_id) ON DELETE SET NULL;


--
-- Name: blanket_agreement fk_agreement_statement; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.blanket_agreement
    ADD CONSTRAINT fk_agreement_statement FOREIGN KEY (statement_id) REFERENCES sales.statement(statement_id) ON DELETE CASCADE;


--
-- Name: campaign_contacts fk_campaign_contact_campaign; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.campaign_contacts
    ADD CONSTRAINT fk_campaign_contact_campaign FOREIGN KEY (campaign_id) REFERENCES sales.campaigns(campaign_id) ON DELETE CASCADE;


--
-- Name: campaign_contacts fk_cc_customer_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.campaign_contacts
    ADD CONSTRAINT fk_cc_customer_id FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id) ON DELETE CASCADE;


--
-- Name: customers fk_customer_gl_account; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customers
    ADD CONSTRAINT fk_customer_gl_account FOREIGN KEY (gl_account_id) REFERENCES accounting.general_ledger_accounts(gl_account_id) ON DELETE CASCADE;


--
-- Name: customers fk_customer_partner; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.customers
    ADD CONSTRAINT fk_customer_partner FOREIGN KEY (partner_id) REFERENCES admin.business_partner_master(partner_id) ON DELETE CASCADE;


--
-- Name: delivery_note fk_delivery_note_order; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.delivery_note
    ADD CONSTRAINT fk_delivery_note_order FOREIGN KEY (order_id) REFERENCES sales.orders(order_id) ON DELETE CASCADE;


--
-- Name: delivery_note fk_delivery_note_rework; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.delivery_note
    ADD CONSTRAINT fk_delivery_note_rework FOREIGN KEY (rework_id) REFERENCES distribution.rework_order(rework_id) ON DELETE SET NULL;


--
-- Name: delivery_note fk_delivery_note_shipment; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.delivery_note
    ADD CONSTRAINT fk_delivery_note_shipment FOREIGN KEY (shipment_id) REFERENCES distribution.shipment_details(shipment_id) ON DELETE CASCADE;


--
-- Name: delivery_note fk_delivery_note_statement_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.delivery_note
    ADD CONSTRAINT fk_delivery_note_statement_id FOREIGN KEY (statement_id) REFERENCES sales.statement(statement_id) ON DELETE CASCADE;


--
-- Name: opportunities fk_opportunities_customer; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.opportunities
    ADD CONSTRAINT fk_opportunities_customer FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id) ON DELETE CASCADE;


--
-- Name: opportunities fk_opportunities_partner; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.opportunities
    ADD CONSTRAINT fk_opportunities_partner FOREIGN KEY (partner_id) REFERENCES admin.business_partner_master(partner_id) ON DELETE CASCADE;


--
-- Name: opportunities fk_opportunities_salesrep; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.opportunities
    ADD CONSTRAINT fk_opportunities_salesrep FOREIGN KEY (salesrep_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: orders fk_orders_agreement; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_agreement FOREIGN KEY (agreement_id) REFERENCES sales.blanket_agreement(agreement_id) ON DELETE SET NULL;


--
-- Name: orders fk_orders_ext_project_request; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_ext_project_request FOREIGN KEY (ext_project_request_id) REFERENCES project_management.external_project_request(ext_project_request_id) ON DELETE SET NULL;


--
-- Name: orders fk_orders_quotation; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_quotation FOREIGN KEY (quotation_id) REFERENCES sales.quotation(quotation_id) ON DELETE SET NULL;


--
-- Name: orders fk_orders_statement; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.orders
    ADD CONSTRAINT fk_orders_statement FOREIGN KEY (statement_id) REFERENCES sales.statement(statement_id) ON DELETE CASCADE;


--
-- Name: payments fk_payments_order; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.payments
    ADD CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES sales.orders(order_id) ON DELETE CASCADE;


--
-- Name: quotation fk_quotation_agreement; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.quotation
    ADD CONSTRAINT fk_quotation_agreement FOREIGN KEY (agreement_id) REFERENCES sales.blanket_agreement(agreement_id) ON DELETE SET NULL;


--
-- Name: quotation fk_quotation_statement; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.quotation
    ADD CONSTRAINT fk_quotation_statement FOREIGN KEY (statement_id) REFERENCES sales.statement(statement_id) ON DELETE CASCADE;


--
-- Name: return fk_return_delivery_note_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.return
    ADD CONSTRAINT fk_return_delivery_note_id FOREIGN KEY (delivery_note_id) REFERENCES sales.delivery_note(delivery_note_id) ON DELETE CASCADE;


--
-- Name: return fk_return_statement_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.return
    ADD CONSTRAINT fk_return_statement_id FOREIGN KEY (statement_id) REFERENCES sales.statement(statement_id) ON DELETE CASCADE;


--
-- Name: sales_invoices fk_sales_invoices_order; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.sales_invoices
    ADD CONSTRAINT fk_sales_invoices_order FOREIGN KEY (delivery_note_id) REFERENCES sales.delivery_note(delivery_note_id) ON DELETE CASCADE;


--
-- Name: product_pricing fk_sales_pp_admin_product_id; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.product_pricing
    ADD CONSTRAINT fk_sales_pp_admin_product_id FOREIGN KEY (admin_product_id) REFERENCES admin.products(product_id) ON DELETE CASCADE;


--
-- Name: statement_item fk_sitem_product; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.statement_item
    ADD CONSTRAINT fk_sitem_product FOREIGN KEY (product_id) REFERENCES admin.products(product_id) ON DELETE SET NULL;


--
-- Name: statement_item fk_sitem_statement; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.statement_item
    ADD CONSTRAINT fk_sitem_statement FOREIGN KEY (statement_id) REFERENCES sales.statement(statement_id) ON DELETE CASCADE;


--
-- Name: statement fk_statement_customer; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.statement
    ADD CONSTRAINT fk_statement_customer FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id) ON DELETE CASCADE;


--
-- Name: statement fk_statement_salesrep; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.statement
    ADD CONSTRAINT fk_statement_salesrep FOREIGN KEY (salesrep_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: ticket_convo fk_ticket_convo_ticket; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.ticket_convo
    ADD CONSTRAINT fk_ticket_convo_ticket FOREIGN KEY (ticket_id) REFERENCES sales.ticket(ticket_id) ON DELETE CASCADE;


--
-- Name: ticket fk_tickets_customer; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.ticket
    ADD CONSTRAINT fk_tickets_customer FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id) ON DELETE CASCADE;


--
-- Name: ticket fk_tickets_salesrep; Type: FK CONSTRAINT; Schema: sales; Owner: postgres
--

ALTER TABLE ONLY sales.ticket
    ADD CONSTRAINT fk_tickets_salesrep FOREIGN KEY (salesrep_id) REFERENCES human_resources.employees(employee_id) ON DELETE CASCADE;


--
-- Name: after_analysis_sched after_analysis_sched_analysis_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.after_analysis_sched
    ADD CONSTRAINT after_analysis_sched_analysis_fk FOREIGN KEY (analysis_id) REFERENCES services.service_analysis(analysis_id);


--
-- Name: after_analysis_sched after_analysis_sched_technician_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.after_analysis_sched
    ADD CONSTRAINT after_analysis_sched_technician_fk FOREIGN KEY (technician_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: delivery_order delivery_order_customer_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.delivery_order
    ADD CONSTRAINT delivery_order_customer_fk FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id);


--
-- Name: delivery_order delivery_order_service_order_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.delivery_order
    ADD CONSTRAINT delivery_order_service_order_fk FOREIGN KEY (service_order_id) REFERENCES services.service_order(service_order_id);


--
-- Name: additional_service_type fk_additional_service_type; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.additional_service_type
    ADD CONSTRAINT fk_additional_service_type FOREIGN KEY (additional_service_id) REFERENCES services.additional_service(additional_service_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_analysis fk_service_analysis_contract; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_analysis
    ADD CONSTRAINT fk_service_analysis_contract FOREIGN KEY (contract_id) REFERENCES services.service_contract(contract_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_billing fk_service_billing_operational_cost; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_billing
    ADD CONSTRAINT fk_service_billing_operational_cost FOREIGN KEY (operational_cost_id) REFERENCES distribution.operational_cost(operational_cost_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_billing fk_service_billing_renewal; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_billing
    ADD CONSTRAINT fk_service_billing_renewal FOREIGN KEY (renewal_id) REFERENCES services.warranty_renewal(renewal_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_billing fk_service_billing_service_analysis; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_billing
    ADD CONSTRAINT fk_service_billing_service_analysis FOREIGN KEY (analysis_id) REFERENCES services.service_analysis(analysis_id);


--
-- Name: service_call fk_service_call_contract; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_call
    ADD CONSTRAINT fk_service_call_contract FOREIGN KEY (contract_id) REFERENCES services.service_contract(contract_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_call fk_service_call_product; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_call
    ADD CONSTRAINT fk_service_call_product FOREIGN KEY (product_id) REFERENCES admin.products(product_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_contract fk_service_contract_additional_service; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_contract
    ADD CONSTRAINT fk_service_contract_additional_service FOREIGN KEY (additional_service_id) REFERENCES services.additional_service(additional_service_id) ON DELETE SET NULL;


--
-- Name: service_contract fk_service_contract_order; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_contract
    ADD CONSTRAINT fk_service_contract_order FOREIGN KEY (statement_item_id) REFERENCES sales.statement_item(statement_item_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_contract fk_service_contract_renewal; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_contract
    ADD CONSTRAINT fk_service_contract_renewal FOREIGN KEY (renewal_id) REFERENCES services.warranty_renewal(renewal_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_order_item fk_service_order_item; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_order_item
    ADD CONSTRAINT fk_service_order_item FOREIGN KEY (item_id) REFERENCES inventory.inventory_item_threshold(inventory_item_threshold_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_report fk_service_report_renewal; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_report
    ADD CONSTRAINT fk_service_report_renewal FOREIGN KEY (renewal_id) REFERENCES services.warranty_renewal(renewal_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_report fk_service_report_request; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_report
    ADD CONSTRAINT fk_service_report_request FOREIGN KEY (service_request_id) REFERENCES services.service_request(service_request_id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: service_analysis service_analysis_customer_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_analysis
    ADD CONSTRAINT service_analysis_customer_fk FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id);


--
-- Name: service_analysis service_analysis_product_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_analysis
    ADD CONSTRAINT service_analysis_product_fk FOREIGN KEY (product_id) REFERENCES admin.products(product_id);


--
-- Name: service_analysis service_analysis_service_request_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_analysis
    ADD CONSTRAINT service_analysis_service_request_fk FOREIGN KEY (service_request_id) REFERENCES services.service_request(service_request_id);


--
-- Name: service_analysis service_analysis_technician_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_analysis
    ADD CONSTRAINT service_analysis_technician_fk FOREIGN KEY (technician_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: service_billing service_billing_service_order_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_billing
    ADD CONSTRAINT service_billing_service_order_fk FOREIGN KEY (service_order_id) REFERENCES services.service_order(service_order_id);


--
-- Name: service_billing service_billing_service_request_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_billing
    ADD CONSTRAINT service_billing_service_request_fk FOREIGN KEY (service_request_id) REFERENCES services.service_request(service_request_id);


--
-- Name: service_call service_call_customer_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_call
    ADD CONSTRAINT service_call_customer_fk FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id);


--
-- Name: service_call service_call_technician_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_call
    ADD CONSTRAINT service_call_technician_fk FOREIGN KEY (technician_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: service_contract service_contract_customer_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_contract
    ADD CONSTRAINT service_contract_customer_fk FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id);


--
-- Name: service_contract service_contract_product_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_contract
    ADD CONSTRAINT service_contract_product_fk FOREIGN KEY (product_id) REFERENCES admin.products(product_id);


--
-- Name: service_order service_order_analysis_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_order
    ADD CONSTRAINT service_order_analysis_fk FOREIGN KEY (analysis_id) REFERENCES services.service_analysis(analysis_id);


--
-- Name: service_order service_order_customer_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_order
    ADD CONSTRAINT service_order_customer_fk FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id);


--
-- Name: service_order_item service_order_item_order_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_order_item
    ADD CONSTRAINT service_order_item_order_fk FOREIGN KEY (service_order_id) REFERENCES services.service_order(service_order_id) ON DELETE CASCADE;


--
-- Name: service_order_item service_order_item_principal_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_order_item
    ADD CONSTRAINT service_order_item_principal_fk FOREIGN KEY (principal_item_id) REFERENCES mrp.principal_items(principal_item_id);


--
-- Name: service_report service_report_service_billing_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_report
    ADD CONSTRAINT service_report_service_billing_fk FOREIGN KEY (service_billing_id) REFERENCES services.service_billing(service_billing_id);


--
-- Name: service_report service_report_service_call_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_report
    ADD CONSTRAINT service_report_service_call_fk FOREIGN KEY (service_call_id) REFERENCES services.service_call(service_call_id);


--
-- Name: service_report service_report_service_ticket_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_report
    ADD CONSTRAINT service_report_service_ticket_fk FOREIGN KEY (service_ticket_id) REFERENCES sales.ticket(ticket_id);


--
-- Name: service_report service_report_technician_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_report
    ADD CONSTRAINT service_report_technician_fk FOREIGN KEY (technician_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: service_request service_request_customer_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_request
    ADD CONSTRAINT service_request_customer_fk FOREIGN KEY (customer_id) REFERENCES sales.customers(customer_id);


--
-- Name: service_request service_request_service_call_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_request
    ADD CONSTRAINT service_request_service_call_fk FOREIGN KEY (service_call_id) REFERENCES services.service_call(service_call_id);


--
-- Name: service_request service_request_technician_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_request
    ADD CONSTRAINT service_request_technician_fk FOREIGN KEY (technician_id) REFERENCES human_resources.employees(employee_id);


--
-- Name: service_call service_ticket_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.service_call
    ADD CONSTRAINT service_ticket_fk FOREIGN KEY (service_ticket_id) REFERENCES sales.ticket(ticket_id);


--
-- Name: warranty_renewal warranty_renewal_call_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.warranty_renewal
    ADD CONSTRAINT warranty_renewal_call_fk FOREIGN KEY (service_call_id) REFERENCES services.service_call(service_call_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: warranty_renewal warranty_renewal_contract_fk; Type: FK CONSTRAINT; Schema: services; Owner: postgres
--

ALTER TABLE ONLY services.warranty_renewal
    ADD CONSTRAINT warranty_renewal_contract_fk FOREIGN KEY (contract_id) REFERENCES services.service_contract(contract_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA accounting; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA accounting TO PUBLIC;


--
-- Name: SCHEMA admin; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA admin TO PUBLIC;


--
-- Name: SCHEMA distribution; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA distribution TO PUBLIC;


--
-- Name: SCHEMA finance; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA finance TO PUBLIC;


--
-- Name: SCHEMA human_resources; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA human_resources TO PUBLIC;


--
-- Name: SCHEMA inventory; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA inventory TO PUBLIC;


--
-- Name: SCHEMA management; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA management TO PUBLIC;


--
-- Name: SCHEMA mrp; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA mrp TO PUBLIC;


--
-- Name: SCHEMA operations; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA operations TO PUBLIC;


--
-- Name: SCHEMA production; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA production TO PUBLIC;


--
-- Name: SCHEMA project_management; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA project_management TO PUBLIC;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- Name: SCHEMA purchasing; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA purchasing TO PUBLIC;


--
-- Name: SCHEMA sales; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA sales TO PUBLIC;


--
-- Name: SCHEMA services; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA services TO PUBLIC;


--
-- Name: SCHEMA solution_customizing; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA solution_customizing TO PUBLIC;


--
-- Name: TABLE chart_of_accounts; Type: ACL; Schema: accounting; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE accounting.chart_of_accounts TO erp_user;


--
-- Name: TABLE financial_report; Type: ACL; Schema: accounting; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE accounting.financial_report TO erp_user;


--
-- Name: TABLE general_ledger_accounts; Type: ACL; Schema: accounting; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE accounting.general_ledger_accounts TO erp_user;


--
-- Name: TABLE journal_entries; Type: ACL; Schema: accounting; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE accounting.journal_entries TO erp_user;


--
-- Name: TABLE journal_entry_lines; Type: ACL; Schema: accounting; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE accounting.journal_entry_lines TO erp_user;


--
-- Name: TABLE official_receipts; Type: ACL; Schema: accounting; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE accounting.official_receipts TO erp_user;


--
-- Name: TABLE assets; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.assets TO erp_user;


--
-- Name: TABLE audit_log; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.audit_log TO erp_user;


--
-- Name: TABLE business_partner_master; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.business_partner_master TO erp_user;


--
-- Name: TABLE currency; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.currency TO erp_user;


--
-- Name: TABLE item_master_data; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.item_master_data TO erp_user;


--
-- Name: TABLE notifications; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.notifications TO erp_user;


--
-- Name: TABLE policies; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.policies TO erp_user;


--
-- Name: TABLE products; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.products TO erp_user;


--
-- Name: TABLE raw_materials; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.raw_materials TO erp_user;


--
-- Name: TABLE roles_permission; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.roles_permission TO erp_user;


--
-- Name: TABLE users; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.users TO erp_user;


--
-- Name: TABLE vendor; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.vendor TO erp_user;


--
-- Name: TABLE warehouse; Type: ACL; Schema: admin; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE admin.warehouse TO erp_user;


--
-- Name: TABLE billing_receipt; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.billing_receipt TO erp_user;


--
-- Name: TABLE carrier; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.carrier TO erp_user;


--
-- Name: TABLE delivery_order; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.delivery_order TO erp_user;


--
-- Name: TABLE delivery_receipt; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.delivery_receipt TO erp_user;


--
-- Name: TABLE failed_shipment; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.failed_shipment TO erp_user;


--
-- Name: TABLE goods_issue; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.goods_issue TO erp_user;


--
-- Name: TABLE logistics_approval_request; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.logistics_approval_request TO erp_user;


--
-- Name: TABLE operational_cost; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.operational_cost TO erp_user;


--
-- Name: TABLE packing_cost; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.packing_cost TO erp_user;


--
-- Name: TABLE packing_list; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.packing_list TO erp_user;


--
-- Name: TABLE picking_list; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.picking_list TO erp_user;


--
-- Name: TABLE rejection; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.rejection TO erp_user;


--
-- Name: TABLE rework_order; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.rework_order TO erp_user;


--
-- Name: TABLE shipment_details; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.shipment_details TO erp_user;


--
-- Name: TABLE shipping_cost; Type: ACL; Schema: distribution; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE distribution.shipping_cost TO erp_user;


--
-- Name: TABLE budget_allocation; Type: ACL; Schema: finance; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE finance.budget_allocation TO erp_user;


--
-- Name: TABLE budget_approvals; Type: ACL; Schema: finance; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE finance.budget_approvals TO erp_user;


--
-- Name: TABLE budget_request_form; Type: ACL; Schema: finance; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE finance.budget_request_form TO erp_user;


--
-- Name: TABLE budget_returns_form; Type: ACL; Schema: finance; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE finance.budget_returns_form TO erp_user;


--
-- Name: TABLE budget_submission; Type: ACL; Schema: finance; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE finance.budget_submission TO erp_user;


--
-- Name: TABLE budget_validations; Type: ACL; Schema: finance; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE finance.budget_validations TO erp_user;


--
-- Name: TABLE attendance_tracking; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.attendance_tracking TO erp_user;


--
-- Name: TABLE calendar_dates; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.calendar_dates TO erp_user;


--
-- Name: TABLE candidates; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.candidates TO erp_user;


--
-- Name: TABLE department_superiors; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.department_superiors TO erp_user;


--
-- Name: TABLE departments; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.departments TO erp_user;


--
-- Name: TABLE employee_leave_balances; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.employee_leave_balances TO erp_user;


--
-- Name: TABLE employee_performance; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.employee_performance TO erp_user;


--
-- Name: TABLE employee_salary; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.employee_salary TO erp_user;


--
-- Name: TABLE employees; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.employees TO erp_user;


--
-- Name: TABLE job_posting; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.job_posting TO erp_user;


--
-- Name: TABLE leave_requests; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.leave_requests TO erp_user;


--
-- Name: TABLE payroll; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.payroll TO erp_user;


--
-- Name: TABLE positions; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.positions TO erp_user;


--
-- Name: TABLE resignations; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.resignations TO erp_user;


--
-- Name: TABLE workforce_allocation; Type: ACL; Schema: human_resources; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE human_resources.workforce_allocation TO erp_user;


--
-- Name: TABLE deprecation_report; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.deprecation_report TO erp_user;


--
-- Name: TABLE expiry_report; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.expiry_report TO erp_user;


--
-- Name: TABLE inventory_adjustments; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.inventory_adjustments TO erp_user;


--
-- Name: TABLE inventory_cyclic_counts; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.inventory_cyclic_counts TO erp_user;


--
-- Name: TABLE inventory_item; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.inventory_item TO erp_user;


--
-- Name: TABLE inventory_item_threshold; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.inventory_item_threshold TO erp_user;


--
-- Name: TABLE warehouse_movement; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.warehouse_movement TO erp_user;


--
-- Name: TABLE warehouse_movement_items; Type: ACL; Schema: inventory; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE inventory.warehouse_movement_items TO erp_user;


--
-- Name: TABLE management_approvals; Type: ACL; Schema: management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE management.management_approvals TO erp_user;


--
-- Name: TABLE bill_of_materials; Type: ACL; Schema: mrp; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE mrp.bill_of_materials TO erp_user;


--
-- Name: TABLE labor_cost; Type: ACL; Schema: mrp; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE mrp.labor_cost TO erp_user;


--
-- Name: TABLE non_project_order_pricing; Type: ACL; Schema: mrp; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE mrp.non_project_order_pricing TO erp_user;


--
-- Name: TABLE principal_items; Type: ACL; Schema: mrp; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE mrp.principal_items TO erp_user;


--
-- Name: TABLE product_mats; Type: ACL; Schema: mrp; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE mrp.product_mats TO erp_user;


--
-- Name: TABLE document_header; Type: ACL; Schema: operations; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE operations.document_header TO erp_user;


--
-- Name: TABLE document_items; Type: ACL; Schema: operations; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE operations.document_items TO erp_user;


--
-- Name: TABLE external_module; Type: ACL; Schema: operations; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE operations.external_module TO erp_user;


--
-- Name: TABLE product_document_items; Type: ACL; Schema: operations; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE operations.product_document_items TO erp_user;


--
-- Name: TABLE serial_tracking; Type: ACL; Schema: operations; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE operations.serial_tracking TO erp_user;


--
-- Name: TABLE equipment; Type: ACL; Schema: production; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE production.equipment TO erp_user;


--
-- Name: TABLE labor; Type: ACL; Schema: production; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE production.labor TO erp_user;


--
-- Name: TABLE production_orders_details; Type: ACL; Schema: production; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE production.production_orders_details TO erp_user;


--
-- Name: TABLE production_orders_header; Type: ACL; Schema: production; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE production.production_orders_header TO erp_user;


--
-- Name: TABLE project_equipment; Type: ACL; Schema: production; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE production.project_equipment TO erp_user;


--
-- Name: TABLE rework_cost; Type: ACL; Schema: production; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE production.rework_cost TO erp_user;


--
-- Name: TABLE external_project_cost_management; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_cost_management TO erp_user;


--
-- Name: TABLE external_project_details; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_details TO erp_user;


--
-- Name: TABLE external_project_equipments; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_equipments TO erp_user;


--
-- Name: TABLE external_project_labor; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_labor TO erp_user;


--
-- Name: TABLE external_project_request; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_request TO erp_user;


--
-- Name: TABLE external_project_task_list; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_task_list TO erp_user;


--
-- Name: TABLE external_project_tracking; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_tracking TO erp_user;


--
-- Name: TABLE external_project_warranty; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.external_project_warranty TO erp_user;


--
-- Name: TABLE internal_project_cost_management; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.internal_project_cost_management TO erp_user;


--
-- Name: TABLE internal_project_details; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.internal_project_details TO erp_user;


--
-- Name: TABLE internal_project_labor; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.internal_project_labor TO erp_user;


--
-- Name: TABLE internal_project_request; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.internal_project_request TO erp_user;


--
-- Name: TABLE internal_project_task_list; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.internal_project_task_list TO erp_user;


--
-- Name: TABLE internal_project_tracking; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.internal_project_tracking TO erp_user;


--
-- Name: TABLE report_monitoring; Type: ACL; Schema: project_management; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE project_management.report_monitoring TO erp_user;


--
-- Name: TABLE batch_inspection; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.batch_inspection TO erp_user;


--
-- Name: TABLE credit_memo; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.credit_memo TO erp_user;


--
-- Name: TABLE purchase_invoice; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.purchase_invoice TO erp_user;


--
-- Name: TABLE purchase_order; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.purchase_order TO erp_user;


--
-- Name: TABLE purchase_quotation; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.purchase_quotation TO erp_user;


--
-- Name: TABLE purchase_requests; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.purchase_requests TO erp_user;


--
-- Name: TABLE quotation_contents; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.quotation_contents TO erp_user;


--
-- Name: TABLE received_shipments; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.received_shipments TO erp_user;


--
-- Name: TABLE vendor_application; Type: ACL; Schema: purchasing; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE purchasing.vendor_application TO erp_user;


--
-- Name: TABLE blanket_agreement; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.blanket_agreement TO erp_user;


--
-- Name: TABLE campaign_contacts; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.campaign_contacts TO erp_user;


--
-- Name: TABLE campaigns; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.campaigns TO erp_user;


--
-- Name: TABLE customers; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.customers TO erp_user;


--
-- Name: TABLE delivery_note; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.delivery_note TO erp_user;


--
-- Name: TABLE opportunities; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.opportunities TO erp_user;


--
-- Name: TABLE orders; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.orders TO erp_user;


--
-- Name: TABLE payments; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.payments TO erp_user;


--
-- Name: TABLE product_pricing; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.product_pricing TO erp_user;


--
-- Name: TABLE quotation; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.quotation TO erp_user;


--
-- Name: TABLE return; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.return TO erp_user;


--
-- Name: TABLE sales_invoices; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.sales_invoices TO erp_user;


--
-- Name: TABLE statement; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.statement TO erp_user;


--
-- Name: TABLE statement_item; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.statement_item TO erp_user;


--
-- Name: TABLE ticket; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.ticket TO erp_user;


--
-- Name: TABLE ticket_convo; Type: ACL; Schema: sales; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE sales.ticket_convo TO erp_user;


--
-- Name: TABLE additional_service; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.additional_service TO erp_user;


--
-- Name: TABLE additional_service_type; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.additional_service_type TO erp_user;


--
-- Name: TABLE after_analysis_sched; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.after_analysis_sched TO erp_user;


--
-- Name: TABLE delivery_order; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.delivery_order TO erp_user;


--
-- Name: TABLE service_analysis; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_analysis TO erp_user;


--
-- Name: TABLE service_billing; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_billing TO erp_user;


--
-- Name: TABLE service_call; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_call TO erp_user;


--
-- Name: TABLE service_contract; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_contract TO erp_user;


--
-- Name: TABLE service_order; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_order TO erp_user;


--
-- Name: TABLE service_order_item; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_order_item TO erp_user;


--
-- Name: TABLE service_report; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_report TO erp_user;


--
-- Name: TABLE service_request; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.service_request TO erp_user;


--
-- Name: TABLE warranty_renewal; Type: ACL; Schema: services; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE services.warranty_renewal TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: accounting; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA accounting GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: admin; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA admin GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: distribution; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA distribution GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: finance; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA finance GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: human_resources; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA human_resources GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: inventory; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA inventory GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: management; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA management GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: mrp; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA mrp GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: operations; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA operations GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: production; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA production GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: project_management; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA project_management GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: purchasing; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA purchasing GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: sales; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA sales GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: services; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA services GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: solution_customizing; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA solution_customizing GRANT SELECT,INSERT,UPDATE ON TABLES TO erp_user;


--
-- PostgreSQL database dump complete
--

