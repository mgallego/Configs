 pear config-set auto_discover 1
 pear channel-discover pear.phpunit.de
 pear channel-discover components.ez.no
 pear channel-discover pear.symfony-project.com
 pear channel-discover pear.phpmd.org
 pear channel-discover pear.pdepend.org
 pear channel-discover pear.phpdoc.org
 pear channel-discover pear.phing.info
 pear channel-discover pear.phpqatools.org
 pear channel-discover pear.netpirates.net

 pear install -f --alldeps symfony/YAML
 pear install -f --alldeps components.ez.no/ConsoleTools

 pear install -f --alldeps phpunit/PHPUnit
 pear install -f --alldeps PHP_CodeSniffer
 pear install -f --alldeps phpmd/PHP_PMD

 pecl install -f --alldeps xdebug
 pear install -f --alldeps phing/phing

 pear install -f --alldeps pear.phpqatools.org/phpqatools
 pear install -f --alldeps pear.netpirates.net/phpDox
 pear install -f --alldeps Image_GraphViz

 pear install -f --alldeps pear.phpunit.de/phploc
 pear uninstall phpdocumentor
 pear install -f --alldeps phpdoc/phpDocumentor-alpha
