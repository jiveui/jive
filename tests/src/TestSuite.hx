import massive.munit.TestSuite;

import jive.ComponentTest;
import jive.DataBindingTest;
import jive.SvgTest;
import jive.TemplatedComponentTest;
import jive.WindowTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(jive.ComponentTest);
		add(jive.DataBindingTest);
		add(jive.SvgTest);
		add(jive.TemplatedComponentTest);
		add(jive.WindowTest);
	}
}
