declare
  kredity number;
  oc number := 500438;
begin
  kredity := pocet_kreditov(oc);
  dbms_output.put_line('Pocet kreditov studenta ' || oc || ' je ' || kredity);
end;
/