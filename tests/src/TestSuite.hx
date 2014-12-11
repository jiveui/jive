import massive.munit.TestSuite;

import jive.DataBindingTest;
import org.aswing.BordersTest;
import org.aswing.ComponentTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(jive.DataBindingTest);
		add(org.aswing.BordersTest);
		add(org.aswing.ComponentTest);
	}
}
