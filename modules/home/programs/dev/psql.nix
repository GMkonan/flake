{pkgs, ...}: {
  home.packages = with pkgs; [
    postgresql
  ];

  home.file.".psqlrc".text = ''
    -- Better formatting
    \x auto
    \pset null '(null)'
    \pset format wrapped
    \pset linestyle unicode
    \pset border 2

    -- Timing and history
    \timing on
    \set HISTSIZE 10000
    \set HISTCONTROL ignoredups

    -- Better prompts
    \set PROMPT1 '%[%033[1;32m%]%M%[%033[0m%] %[%033[1;34m%]%n%[%033[0m%]@%[%033[1;36m%]%/%[%033[0m%]%R%# '
    \set PROMPT2 '%[%033[1;33m%]%R%[%033[0m%]%# '

    -- Useful shortcuts
    \set version 'SELECT version();'
    \set extensions 'SELECT * FROM pg_available_extensions ORDER BY name;'
    \set tables 'SELECT schemaname, tablename, tableowner FROM pg_tables WHERE schemaname NOT IN ('information_schema', 'pg_catalog') ORDER BY schemaname, tablename;'
    \set indexes 'SELECT schemaname, tablename, indexname FROM pg_indexes WHERE schemaname NOT IN ('information_schema', 'pg_catalog') ORDER BY schemaname, tablename, indexname;'

    -- Error handling
    \set ON_ERROR_ROLLBACK interactive
    \set VERBOSITY verbose

    -- Pager settings
    \pset pager always
  '';
}
