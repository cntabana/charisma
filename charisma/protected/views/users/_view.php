<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('firstname')); ?>:
	<?php echo GxHtml::encode($data->firstname); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('middlename')); ?>:
	<?php echo GxHtml::encode($data->middlename); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('lastname')); ?>:
	<?php echo GxHtml::encode($data->lastname); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('username')); ?>:
	<?php echo GxHtml::encode($data->username); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('password')); ?>:
	<?php echo GxHtml::encode($data->password); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('salt')); ?>:
	<?php echo GxHtml::encode($data->salt); ?>
	<br />
	<?php /*
	<?php echo GxHtml::encode($data->getAttributeLabel('group')); ?>:
	<?php echo GxHtml::encode($data->group); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('status')); ?>:
	<?php echo GxHtml::encode($data->status); ?>
	<br />
	*/ ?>

</div>