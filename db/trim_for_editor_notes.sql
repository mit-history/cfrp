-- trim leading and trailing whitespace from editor notes
--   (addresses many cr+lf faults)


UPDATE registers SET misc_notes = regexp_replace(misc_notes, '^\\s*', '');

UPDATE registers SET misc_notes = regexp_replace(misc_notes, '\\s*$', '');

UPDATE registers SET for_editor_notes = regexp_replace(for_editor_notes, '^\\s*', '');

UPDATE registers SET for_editor_notes = regexp_replace(for_editor_notes, '\\s*$', '');