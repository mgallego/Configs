sudo pear config-set auto_discover 1
sudo pear channel-discover pear.phpunit.de
sudo pear channel-discover components.ez.no
sudo pear channel-discover pear.symfony-project.com
sudo pear channel-discover pear.phpmd.org
sudo pear channel-discover pear.pdepend.org
sudo pear channel-discover pear.phpdoc.org
sudo pear channel-discover pear.phing.info
sudo pear channel-discover pear.phpqatools.org
sudo pear channel-discover pear.netpirates.net

sudo pear install -f --alldeps symfony/YAML
sudo pear install -f --alldeps components.ez.no/ConsoleTools

sudo pear install -f --alldeps phpunit/PHPUnit
sudo pear install -f --alldeps PHP_CodeSniffer
sudo pear install -f --alldeps phpmd/PHP_PMD

sudo pecl install -f --alldeps xdebug
sudo pear install -f --alldeps phing/phing

sudo pear install -f --alldeps pear.phpqatools.org/phpqatools
sudo pear install -f --alldeps pear.netpirates.net/phpDox
sudo pear install -f --alldeps Image_GraphViz

sudo pear install -f --alldeps pear.phpunit.de/phploc
sudo pear uninstall phpdocumentor
sudo pear install -f --alldeps phpdoc/phpDocumentor-alpha
