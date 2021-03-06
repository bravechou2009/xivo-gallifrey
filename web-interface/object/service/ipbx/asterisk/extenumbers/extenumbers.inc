<?php

#
# XiVO Web-Interface
# Copyright (C) 2006-2010  Proformatique <technique@proformatique.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

xivo_service_asterisk::required(array('abstract','abstract.inc'),true);

class xivo_service_asterisk_extenumbers extends xivo_service_asterisk_abstract
{
	var $_dso		= null;
	var $_name		= 'extenumbers';
	var $_filter		= false;
	var $_origin		= false;

	function xivo_service_asterisk_extenumbers(&$sre,&$dso)
	{
		if(is_object($sre) === false)
			trigger_error('Invalid service in '.__CLASS__,E_USER_ERROR);

		if(is_object($dso) === false)
			trigger_error('Invalid datastorage in '.__CLASS__,E_USER_ERROR);

		$this->_sre = &$sre;
		$this->_dso = &$dso;

		$this->_load_config();
	}

	function _prepare($data)
	{
		if(dwho_has_len($data,'exten') === true)
			$data['exten'] = $this->_sre->display_extension($data['exten']);

		return($data);
	}

	function add($arr,$id=0)
	{
		if(is_array($arr) === false)
			return(false);
		else if(dwho_has_len($arr,'exten') === false
		|| ($exten = $this->_sre->chk_extension($arr['exten'])) === false)
			return(false);

		$arr['extenhash'] = sha1($exten);
		$arr['exten'] = $this->_sre->clean_extension($arr['exten']);

		return(parent::add($arr,$id));
	}

	function edit($id,$arr)
	{
		if(is_array($arr) === false)
			return(false);

		unset($arr['extenhash']);

		if(dwho_has_len($arr,'exten') === true)
		{
			if(($exten = $this->_sre->chk_extension($arr['exten'])) === false)
				return(false);

			$arr['extenhash'] = sha1($exten);
			$arr['exten'] = $this->_sre->clean_extension($arr['exten']);
		}

		return(parent::edit($id,$arr));
	}

	function exists_type($arr)
	{
		if(is_array($arr) === false
		|| dwho_has_len($arr,'exten') === false
		|| dwho_has_len($arr,'type') === false
		|| ($exten = $this->_sre->chk_extension($arr['exten'])) === false)
			return(null);

		$extenhash = sha1($exten);

		$where = array();
		$where['extenhash'] = $extenhash;

		$typeval = dwho_has_len($arr,'typeval') === true ? $arr['typeval'] : '';
		$context = dwho_has_len($arr,'context') === true ? $arr['context'] : '';

		$keytype = $arr['type'].'-'.$typeval;

		if(($ret = $this->_dso->exists_type($where,$context)) !== false
		&& ($typeval === '' || $ret['type'].'-'.$ret['typeval'] !== $keytype) === true)
			return(true);

		return(false);
	}

	function search($exten,$context='',$type='',$typeval='')
	{
		if(($extenchk = $this->_sre->chk_extension($exten)) === false)
			return(false);

		$extenhash = sha1($extenchk);

		if(($list = $this->_dso->search($exten,$extenhash,$context,$type,$typeval)) === false)
			return(false);

		$nb = count($list);

		$r = array();

		for($i = 0;$i < $nb;$i++)
			$r[] = $this->_prepare($list[$i]);

		if(isset($r[0]) === false)
			$r = false;

		return($r);
	}
}

?>
