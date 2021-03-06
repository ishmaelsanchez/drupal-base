<?php

/**
 * Implements hook_install_tasks_alter().
 */
function base_install_tasks_alter(&$tasks, $install_state) {
  global $install_state;
 
  // Skip profile selection step 
  $tasks['install_select_profile']['display'] = FALSE;
}

/**
 * Implements hook_form_FORM_ID_alter().
 *
 * Allows the profile to alter the site configuration form.
 */
function base_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name and email address.
  $form['site_information']['site_name']['#default_value'] = $_SERVER['SERVER_NAME'];
  $form['site_information']['site_mail']['#default_value'] = 'no-reply@example.com';

  // Account information defaults
  $form['admin_account']['account']['name']['#default_value'] = $_SERVER['SERVER_NAME'] . 'admin';
  $form['admin_account']['account']['mail']['#default_value'] = 'no-reply@example.com';
  
  // Date/time settings
  $form['server_settings']['site_default_country']['#default_value'] = 'US';
  $form['server_settings']['date_default_timezone']['#default_value'] = 'America/Los Angeles';

  // Opt out of e-mail notifications 
  $form['update_notifications']['update_status_module']["#default_value"]['1'] = '0';

  // Get rid of messages and extra notifications
  base_clean_up();
}

/**
 * Flush cache, run cron, and other clean up
 */
function base_clean_up() {
  
  // Many modules set messages during installation we reset them
  drupal_get_messages('status', TRUE);
  drupal_get_messages('completed', TRUE);
  drupal_get_messages('warning');
  
  // Disable Bartik theme
  db_update('system')
    ->fields(array('status' => 0))
    ->condition('type', 'theme')
    ->condition('name', 'bartik')
    ->execute();
  
  // Run cron and flush cache for good measure
  drupal_cron_run();
  drupal_flush_all_caches();
}

/**
 * Implements hook_install_tasks().
 * 
 * Adds on to the install process
 */
function base_install_tasks() {
  $tasks = array(
    'base_client_form' => array(
      'display_name' => st('Setup Client'),
      'type' => 'form',
    ),
  );
  return $tasks;
}

/** 
 * Custom form for additional configuration
 */
function base_client_form() {
  $form = array();
  $form['intro'] = array(
    '#markup' => '<p>' . st('Setup your default client account below.') . '</p>',
  );
  $form['client_name'] = array(
    '#type' => 'textfield',
    '#title' => st('Client Username'),
    '#required' => TRUE,
  );
  $form['client_mail'] = array(
    '#type' => 'textfield',
    '#title' => st('Client E-mail Address'),
    '#required' => TRUE,
  );
  $form['client_pass'] = array(
    '#type' => 'password',
    '#title' => st('Client Password'),
  );
  $form['submit'] = array(
    '#type' => 'submit',
    '#value' => st('Continue'),
  );
  return $form;
}

/**
 * Form validation
 * 
 */
function base_client_form_validate($form, &$form_state) {
  if (!valid_email_address($form_state['values']['client_mail'])) {
    form_set_error('client_mail', st('Please enter a valid email address'));
  }
}

function base_client_form_submit($form, &$form_state) {
  $values = $form_state['values'];

  // Setup the user account array to programatically create a new user.
  $account = array(
    'name' => $values['client_name'],
    'pass' => !empty($values['client_pass']) ? $values['client_pass'] : user_password(),
    'mail' => $values['client_mail'],
    'status' => 1,
    'init' => $values['client_mail'],
  );
  $account = user_save(null, $account);

  // Assign the client to the "administrator" role.
  $role = user_role_load_by_name('administrator');
  db_insert('users_roles')
    ->fields(array('uid' => $account->uid, 'rid' => $role->rid))
    ->execute();
  
  // For good measure
  drupal_flush_all_caches();
  drupal_cron_run();
}
